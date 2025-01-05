// lib/auth_state.dart
// A quick hack to store token in a static variable
// In a real app, consider using Provider or SharedPreferences.

class AuthState {
  static String? token;
}
