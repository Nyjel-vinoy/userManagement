import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermanagement/provider/auth_provider.dart';
import 'package:usermanagement/provider/user_provider.dart'; // Make sure this is imported
import 'package:usermanagement/screens/login.dart';
import 'package:usermanagement/screens/register.dart';
import 'package:usermanagement/screens/usermanagement.dart';
import 'package:usermanagement/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // ✅ Add this line
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? UserManagementScreen() : Signup(),
        routes: {
          '/login': (context) => Login(),
          '/signup': (context) => Signup(),
          '/user-management': (context) => UserManagementScreen(),
        },
      ),
    );
  }
}
