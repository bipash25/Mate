// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // If you're using Render:
  static const String baseUrl = 'https://mate-rl2h.onrender.com';

  // POST /auth/signup
  static Future<Map<String, dynamic>> signup(String email, String password) async {
    final uri = Uri.parse('$baseUrl/auth/signup');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Status code (signup): ${response.statusCode}');
    print('Response body (signup): ${response.body}');

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // POST /auth/login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Status code (login): ${response.statusCode}');
    print('Response body (login): ${response.body}');

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // GET /auth/profile
  static Future<Map<String, dynamic>> getProfile(String token) async {
    final uri = Uri.parse('$baseUrl/auth/profile');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Attach token
      },
    );

    print('Status code (profile): ${response.statusCode}');
    print('Response body (profile): ${response.body}');
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
