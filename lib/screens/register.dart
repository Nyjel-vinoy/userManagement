import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermanagement/provider/auth_provider.dart';

import 'package:usermanagement/widgets/app_support.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              color: const Color(0XFF4169E1),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height / 1.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Text('Signup', style: appwidget.headLinefeild()),
                            const SizedBox(height: 40),
                            TextFormField(
                              controller: nameController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Name' : null,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                prefixIcon: const Icon(Icons.person_outlined),
                                hintStyle: appwidget.semiBoldfeild(),
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextFormField(
                              controller: emailController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Email' : null,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                hintStyle: appwidget.semiBoldfeild(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Hint : eve.holt@reqres.in',
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Password' : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                hintStyle: appwidget.semiBoldfeild(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Hint : pistol',
                              ),
                            ),
                            const SizedBox(height: 70),
                            authProvider.isLoading
                                ? const CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final success =
                                            await authProvider.signupUser(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                        if (success) {
                                          Navigator.pushReplacementNamed(
                                              context, '/user-management');
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    authProvider.errorMessage ??
                                                        "Signup failed")),
                                          );
                                        }
                                      }
                                    },
                                    child: buildButton("Signup"),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: Text("Already have an account? Login",
                        style: appwidget.semiBoldfeild()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0XFF4169E1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
