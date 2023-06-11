import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/features/auth/login_support.dart';
import 'package:klassy_cafe/src/features/home/home_screen.dart';

class AuthSupport extends StatelessWidget {
  const AuthSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginSupport();
        }
      },
    );
  }
}
