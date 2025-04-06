import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usermanagement/services/secure_storage_service.dart';

class AuthService {
  final SecureStorageService _storageService = SecureStorageService();

  Future<bool> register(String email, String password) async {
    final url = Uri.parse("https://reqres.in/api/register");

    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _storageService.writeToken(data['token']);
      return true;
    } else {
      print("Register failed: ${response.body}");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse("https://reqres.in/api/login");

    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _storageService.writeToken(data['token']);
      return true;
    } else {
      print("Login failed: ${response.body}");
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.deleteToken();
  }

  Future<bool> isLoggedIn() async {
    return await _storageService.hasToken();
  }

  Future<String?> getToken() async {
    return await _storageService.readToken();
  }
}
