import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:pira/pages/landing/landing_page.dart";
import "package:pira/utilities/login_or_register.dart";

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return const LandingPage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
