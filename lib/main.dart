// packages
import 'package:fic/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// screens
import 'auth/login_screen.dart';
import 'firebase_options.dart';

// auth
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Color mainColour = const Color(0xffff0000);
Color secondaryColour1 = const Color(0xffffffff);
Color secondaryColour2 = const Color(0xff000000);
Color secondaryColour3 = const Color(0xffa7a7a7);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luvium',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
