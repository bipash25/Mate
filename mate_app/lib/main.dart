// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart'; // <--- add this import

void main() {
  runApp(const MateApp());
}

class MateApp extends StatelessWidget {
  const MateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        // For demonstration, we define a route that expects arguments
        // We'll do: Navigator.pushNamed(context, '/profile', arguments: token)
        '/profile': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return ProfilePage(token: args);
        },
      },
    );
  }
}
