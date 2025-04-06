import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermanagement/provider/auth_provider.dart';
import 'package:usermanagement/provider/user_provider.dart';
import 'package:usermanagement/widgets/app_support.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUsers();

    _searchController.addListener(() {
      userProvider.filterUsers(_searchController.text);
    });
  }

  Future<void> _logout(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _confirmDelete(BuildContext context, int userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success =
                  await Provider.of<UserProvider>(context, listen: false)
                      .deleteUser(userId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(success ? 'User deleted' : 'Failed to delete user'),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showUpdateUserForm(BuildContext context, dynamic user) {
    final nameController = TextEditingController(text: user['first_name']);
    final jobController = TextEditingController(text: 'Developer');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(labelText: 'Job'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              Navigator.pop(context);
              final success =
                  await Provider.of<UserProvider>(context, listen: false)
                      .updateUser(
                          user['id'], nameController.text, jobController.text);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(success ? 'User updated' : 'Failed to update user'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCreateUserForm(BuildContext context) {
    final nameController = TextEditingController();
    final jobController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Create New User",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Name is required'
                    : null,
              ),
              TextFormField(
                controller: jobController,
                decoration: const InputDecoration(labelText: 'Job'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Job is required'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final created = await Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).createUser(
                      nameController.text.trim(),
                      jobController.text.trim(),
                    );

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            created ? "User created" : "Failed to create user"),
                      ),
                    );
                  }
                },
                child: const Text("Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "User Management",
              style: appwidget.headLinefeild(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _logout(context),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Search by name or email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: userProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : userProvider.users.isEmpty
                        ? const Center(child: Text("No users found"))
                        : ListView.builder(
                            itemCount: userProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = userProvider.users[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user['avatar']),
                                  ),
                                  title: Text(
                                    "${user['first_name']} ${user['last_name']}",
                                    style: TextStyle(color: Color(0XFF4169E1)),
                                  ),
                                  subtitle: Text(
                                    user['email'],
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  trailing: Wrap(
                                    spacing: 12,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Color(0XFF4169E1),
                                        ),
                                        onPressed: () =>
                                            _showUpdateUserForm(context, user),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Color(0XFF4169E1),
                                        ),
                                        onPressed: () =>
                                            _confirmDelete(context, user['id']),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0XFF4169E1),
            onPressed: () => _showCreateUserForm(context),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
