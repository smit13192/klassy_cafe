import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/auth/widget/text_field_border.dart';

class LoginScreen extends StatefulWidget {
  final void Function() onTap;
  const LoginScreen({required this.onTap, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool seen = true;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future sighIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Text(
            AppStrings.loginError,
            style: TextStyle(color: Colors.black87),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                AppStrings.appName,
                style: TextStyle(
                  color: Colors.black87,
                  letterSpacing: 2,
                  fontSize: 40,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty || value.contains(' ')) {
                      return AppStrings.emailError;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                      ),
                      onPressed: () {
                        emailController.clear();
                      },
                    ),
                    hintText: AppStrings.emailHint,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    focusedErrorBorder: focusedErrorBorder,
                    filled: true,
                    fillColor: AppColors.kFAFAFA,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: seen,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.contains(' ')) {
                      return AppStrings.passwordError;
                    } else if (value.length < 8) {
                      return AppStrings.passwordLengthError;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        seen ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        if (seen) {
                          seen = false;
                        } else {
                          seen = true;
                        }
                        setState(() {});
                      },
                    ),
                    hintText: AppStrings.passwordHint,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    focusedErrorBorder: focusedErrorBorder,
                    filled: true,
                    fillColor: AppColors.kFAFAFA,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      sighIn();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        AppStrings.logIn,
                        style: TextStyle(
                          color: AppColors.kFAFAFA,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.accountNotExit,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kDD000000,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        AppStrings.sighUp,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.k2196F3,
                        ),
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
