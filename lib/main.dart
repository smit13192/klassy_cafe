import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klassy_cafe/app/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
