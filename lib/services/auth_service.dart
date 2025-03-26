import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<User?> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      return user;
    } catch (e) {
      print("Sign up ERROR: $e");
      return null;
    }
  }

  static Future<User?> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final User? firebaseUser = auth.currentUser;
      return firebaseUser;
    } catch (e) {
      print("Sign in ERROR: $e");
      return null;
    }
  }

  static bool signOutUser() {
    try {
      auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
