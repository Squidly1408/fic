import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // getting current user
  User? get currentUser => _firebaseAuth.currentUser;

  // get auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // sign in
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // sign out
  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
