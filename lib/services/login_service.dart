import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String baseUrl = 'https://opticcomperu.com/api';

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'email': email, 'password': password},
    );
    return json.decode(response.body);
  }
}
