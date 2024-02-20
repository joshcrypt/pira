import "package:flutter/material.dart";
import 'package:pira/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  // Register User
  void register() async {
    final authService = AuthService();
    // Show Circular dialog
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await authService.signUpWithUsernamePassword(
        emailController.text,
        passwordController.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
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

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   Logo
              const Icon(
                Icons.person,
                size: 40,
              ),
              const Text(
                "Sign Up",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              //   UserName
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "Email"),
              ),
              //   Password
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !validateStructure(value)) {
                    return "Password does not meet security levels";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              // Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      passwordController.text != value) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(hintText: "Confirm Password"),
              ),
              const SizedBox(
                height: 10,
              ),
              //   Login Button
              GestureDetector(
                onTap: () {
                  if (_registerFormKey.currentState!.validate()) {
                    register();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff7c94b6)),
                  height: 50,
                  child: const Center(child: Text("Register")),
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
                    const Text("Already Have an Account,"),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "LOGIN",
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
