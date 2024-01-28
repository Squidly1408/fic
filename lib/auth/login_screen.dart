// packages
import 'package:flutter/material.dart';

// firebase
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth.dart';

// pages
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // error message
  String? errorMessage = '';

  bool isLogin = true;

  final User? user = auth().currentUser;

  Future<void> singInWithEmailAndPassword() async {
    try {
      await auth().signInWithEmailAndPassword(
          email: emailController.text.toLowerCase(),
          password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/fic_login_banner.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/fic_logo.png',
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      // email login details
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(
                            color: secondaryColour2,
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: secondaryColour2,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: secondaryColour2,
                                width: 3,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: secondaryColour2,
                              ),
                            ),
                            hintText: 'Email...',
                            hintStyle: TextStyle(
                              color: secondaryColour2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // password login details
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(
                            color: secondaryColour2,
                          ),
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: const Color(0xff03767b),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: secondaryColour2,
                                width: 3,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: secondaryColour2,
                              ),
                            ),
                            hintText: 'Password...',
                            hintStyle: TextStyle(
                              color: secondaryColour2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMessage == '' ? '' : '$errorMessage',
                          style: TextStyle(
                            color: secondaryColour3,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: secondaryColour2,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          singInWithEmailAndPassword();
                        },
                        color: secondaryColour2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 75),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "This is a student project, aimed to help students and teachers collaborate together at Cooks Hill Campus. Please be respectful while using this tool, thankyou.",
                          style: TextStyle(
                            color: secondaryColour3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
