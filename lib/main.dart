import 'package:flutter/material.dart';
import 'screens/auth/sign_in_screen.dart';

void main() {
  runApp(const CropiaApp());
}

class CropiaApp extends StatelessWidget {
  const CropiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cropia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green.shade600,
          surface: Colors.grey.shade50,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const SignInScreen(),
    );
  }
}
