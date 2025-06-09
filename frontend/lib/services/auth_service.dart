import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final result = await ApiService.post('login', {'email': email, 'password': password});
    if (result['success'] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}
