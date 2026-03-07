import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/sign_in_screen.dart';
import 'providers/field_provider.dart';

import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FieldProvider()),
      ],
      child: const CropiaApp(),
    ),
  );
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
