import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/features/auth/login/login_screen.dart';

import 'register/register_screen.dart';

class LoginSupport extends StatefulWidget {
  const LoginSupport({super.key});

  @override
  State<LoginSupport> createState() => _LoginSupportState();
}

class _LoginSupportState extends State<LoginSupport> {
  bool isLogin = false;

  void onTap() {
    setState(() {
      if (isLogin) {
        isLogin = false;
      } else {
        isLogin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return RegisterScreen(onTap: onTap);
    } else {
      return LoginScreen(onTap: onTap);
    }
  }
}
