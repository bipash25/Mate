// lib/pages/profile_page.dart

import 'package:flutter/material.dart';
import 'package:Mate/services/api_service.dart';
import 'package:Mate/auth_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  String _statusMessage = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    final token = AuthState.token;
    if (token == null) {
      setState(() {
        _statusMessage = 'No token found. Please log in.';
        _isLoading = false;
      });
      return;
    }

    try {
      final result = await ApiService.getProfile(token);
      if (result['success'] == true) {
        final data = result['data'];
        setState(() {
          _email = data['email'] ?? '';
          _statusMessage = result['message'] ?? 'Profile fetched successfully';
        });
      } else {
        // e.g., "Invalid token"
        setState(() {
          _statusMessage = result['message'] ?? 'Failed to fetch profile';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: $e';
      });
    } finally {
      // 'finally' must be directly after the catch block
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is the required build method for State<ProfilePage>.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mate - Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_statusMessage.isNotEmpty)
                    Text(
                      _statusMessage,
                      style: TextStyle(
                        color: _statusMessage.contains('success')
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text('Your Email: $_email'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchProfile,
                    child: const Text('Refresh Profile'),
                  ),
                ],
              ),
      ),
    );
  }
}
