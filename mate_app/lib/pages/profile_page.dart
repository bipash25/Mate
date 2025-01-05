// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:Mate/services/api_service.dart';

class ProfilePage extends StatefulWidget {
  final String token; // JWT from login

  const ProfilePage({Key? key, required this.token}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _email = '';
  String _statusMessage = '';
  bool _isLoading = true;

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

    try {
      final result = await ApiService.getProfile(widget.token);
      if (result['success'] == true) {
        final data = result['data'];
        setState(() {
          _email = data['email'] ?? '';
          _statusMessage = result['message'] ?? '';
        });
      } else {
        setState(() {
          _statusMessage = result['message'] ?? 'Failed to fetch profile';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        color: _statusMessage.contains('successfully')
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
