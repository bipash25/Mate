// lib/main.dart
import 'package:flutter/material.dart';
import 'package:Mate/pages/login_page.dart';
import 'package:Mate/pages/signup_page.dart';
import 'package:Mate/pages/home_page.dart';

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
      },
    );
  }
}
