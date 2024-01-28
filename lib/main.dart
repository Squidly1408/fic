// packages
import 'package:flutter/material.dart';

// screens
import 'auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

Color secondaryColour1 = const Color(0xffffffff);
Color secondaryColour2 = const Color(0xff000000);
Color secondaryColour3 = const Color(0xffa7a7a7);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIC - CHC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
