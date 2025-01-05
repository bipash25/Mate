// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://80-idx-mate-1735957463668.cluster-a3grjzek65cxex762e4mwrzl46.cloudworkstations.dev/'; 
  // For Android emulator; use 'http://localhost:3000' on iOS simulator or adjust as needed.

  // POST /signup
  static Future<Map<String, dynamic>> signup(String email, String password) async {
    final uri = Uri.parse('$baseUrl/auth/signup');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(response.headers);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // POST /login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
