// verifyToken.js
const jwt = require('jsonwebtoken');

// For demonstration, using the same SECRET_KEY as in your server.js
const SECRET_KEY = process.env.SECRET_KEY || 'mysecret';

// This middleware checks for the 'Authorization' header: "Bearer <token>"
module.exports = function verifyToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  if (!authHeader) {
    return res.status(401).json({ success: false, message: 'No token provided' });
  }

  const token = authHeader.split(' ')[1]; // Bearer <token>
  if (!token) {
    return res.status(401).json({ success: false, message: 'Malformed auth header' });
  }

  jwt.verify(token, SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(403).json({ success: false, message: 'Invalid token' });
    }
    // Attach userId or other info to req
    req.userId = decoded.userId;
    next();
  });
};
