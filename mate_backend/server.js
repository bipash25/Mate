// server.js

const express = require('express');
const cors = require('cors');
const { MongoClient } = require('mongodb');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// -- CONFIG --
const app = express();
const PORT = process.env.PORT || 3000;
const SECRET_KEY = process.env.SECRET_KEY || 'mysecret';
const MONGODB_URI = 'mongodb+srv://bipro:bipash@mate.uzdsr.mongodb.net/?retryWrites=true&w=majority&appName=Mate';

// Middlewares
app.use(express.json());
app.use(cors());

// Global variable to hold the db client
let dbClient;
let db;

// Connect to MongoDB
async function connectDB() {
  if (!dbClient) {
    try {
      dbClient = new MongoClient(MONGODB_URI, {
        useNewUrlParser: true,
        useUnifiedTopology: true
      });
      await dbClient.connect();
      db = dbClient.db('mateDB'); // The name of your database
      console.log('✅ Connected to MongoDB Atlas.');
    } catch (error) {
      console.error('❌ Error connecting to MongoDB:', error);
      process.exit(1);
    }
  }
  return db;
}

// ------------------------
// AUTH ROUTES
// ------------------------

// POST /auth/signup
app.post('/auth/signup', async (req, res) => {
  try {
    const database = await connectDB();
    const usersCollection = database.collection('users');

    const { email, password } = req.body;
    if (!email || !password) {
      return res.json({ success: false, message: 'Email and password required' });
    }

    // Check if user exists
    const existingUser = await usersCollection.findOne({ email });
    if (existingUser) {
      return res.json({ success: false, message: 'User already exists' });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insert user
    await usersCollection.insertOne({
      email,
      password: hashedPassword,
      createdAt: new Date()
    });

    res.json({ success: true, message: 'Signup successful' });
  } catch (error) {
    console.error('Error in /auth/signup:', error);
    res.json({ success: false, message: 'Internal server error' });
  }
});

// POST /auth/login
app.post('/auth/login', async (req, res) => {
  try {
    const database = await connectDB();
    const usersCollection = database.collection('users');

    const { email, password } = req.body;
    if (!email || !password) {
      return res.json({ success: false, message: 'Email and password required' });
    }

    const user = await usersCollection.findOne({ email });
    if (!user) {
      return res.json({ success: false, message: 'Invalid email or password' });
    }

    // Compare passwords
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.json({ success: false, message: 'Invalid email or password' });
    }

    // Generate JWT
    const token = jwt.sign({ userId: user._id }, SECRET_KEY, { expiresIn: '1d' });
    res.json({ success: true, message: 'Login successful', token });
  } catch (error) {
    console.error('Error in /auth/login:', error);
    res.json({ success: false, message: 'Internal server error' });
  }
});

// ------------------------
// OTHER ROUTES (Example)
// ------------------------
app.get('/', async (req, res) => {
  return res.send('Hello from Mate backend! Go to /auth/signup or /auth/login for auth.');
});

// Start server
app.listen(PORT, '0.0.0.0', async () => {
  console.log(`Mate backend running on port ${PORT}`);
  await connectDB();
});