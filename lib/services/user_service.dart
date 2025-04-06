import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'https://reqres.in/api';

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    return response.statusCode == 204;
  }

  Future<bool> updateUser(int id, String name, String job) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      body: {'name': name, 'job': job},
    );
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>?> createUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: {'name': name, 'job': job},
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return {
        'id': DateTime.now().millisecondsSinceEpoch, // Fake ID
        'first_name': name,
        'last_name': '',
        'email': '$name@example.com',
        'avatar': 'https://i.pravatar.cc/150?img=${DateTime.now().second}'
      };
    } else {
      return null;
    }
  }
}
