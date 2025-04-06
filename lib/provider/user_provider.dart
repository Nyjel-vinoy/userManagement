import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  List<dynamic> _users = [];
  List<dynamic> _filteredUsers = [];
  bool _isLoading = false;
  String _error = '';

  List<dynamic> get users => _filteredUsers;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _userService.fetchUsers();
      _filteredUsers = _users;
      _error = '';
    } catch (e) {
      _error = 'Failed to fetch users';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = _users;
    } else {
      final lowerQuery = query.toLowerCase();
      _filteredUsers = _users.where((user) {
        final name = user['first_name'].toLowerCase();
        final email = user['email'].toLowerCase();
        return name.contains(lowerQuery) || email.contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  Future<bool> deleteUser(int id) async {
    final success = await _userService.deleteUser(id);
    if (success) {
      _users.removeWhere((user) => user['id'] == id);
      filterUsers(''); // Re-filter based on last search (default empty)
    }
    return success;
  }

  Future<bool> updateUser(int id, String name, String job) async {
    final success = await _userService.updateUser(id, name, job);
    if (success) {
      final index = _users.indexWhere((user) => user['id'] == id);
      if (index != -1) {
        _users[index]['first_name'] = name;
        filterUsers('');
      }
    }
    return success;
  }

  Future<bool> createUser(String name, String job) async {
    final newUser = await _userService.createUser(name, job);
    if (newUser != null) {
      _users.add(newUser);
      filterUsers('');
      return true;
    }
    return false;
  }
}
