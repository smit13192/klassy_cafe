import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/auth/widget/text_field_border.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() onTap;
  const RegisterScreen({required this.onTap, super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool conformSeen = true;
  bool seen = true;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    super.dispose();
  }

  Future logIn() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException {
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
                    } else if (value != conformPasswordController.text) {
                      return AppStrings.samePaswordError;
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
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: conformSeen,
                  controller: conformPasswordController,
                  validator: (value) {
                    if (value!.isEmpty || value.contains(' ')) {
                      return AppStrings.passwordError;
                    } else if (value != passwordController.text) {
                      return AppStrings.samePaswordError;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        conformSeen ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        if (conformSeen) {
                          conformSeen = false;
                        } else {
                          conformSeen = true;
                        }
                        setState(() {});
                      },
                    ),
                    hintText: AppStrings.comformPassword,
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
                      logIn();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.kDD000000,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        AppStrings.sighIn,
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
                      AppStrings.accountExit,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        AppStrings.logIn,
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
