import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:usermanagement/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;
  final AuthService _authService = AuthService();
  // final UserService _userService = UserService();
  List<dynamic> _users = [];
  // List<dynamic> _filteredUsers = [];
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.login(email, password);
      if (!success) _errorMessage = "Invalid login credentials.";
      return success;
    } catch (e) {
      _errorMessage = "Something went wrong!";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signupUser(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.register(email, password);
      if (!success) _errorMessage = "Registration failed.";
      return success;
    } catch (e) {
      _errorMessage = "Something went wrong!";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token'); // ✅ use _storage
    _isAuthenticated = false;
    notifyListeners();
  }
}
