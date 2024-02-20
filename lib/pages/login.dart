import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) async {
    //   Auth service
    final authService = AuthService();

    // Circular loading screen
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //   try login
    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
      // if (context.mounted) {
      //   Navigator.pop(context);
      // }
    } catch (e) {
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text(e.toString()),
      //   ),
      // );
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   Logo
              const Icon(
                Icons.lock,
                size: 40,
              ),
              const Text(
                "Welcome to PIRA",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              //   UserName
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "Email"),
              ),
              //   Password
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 10,
              ),
              //   Login Button
              GestureDetector(
                onTap: () {
                  if (_loginFormKey.currentState!.validate()) {
                    login(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff7c94b6)),
                  height: 50,
                  child: const Center(child: Text("Login")),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //   Toggle Register link
              GestureDetector(
                onTap: widget.onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No Account, Please"),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
