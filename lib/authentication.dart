import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<AuthResult> signIn(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<AuthResult> createUser(String email, String password) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return newUser;
  }

  Future<FirebaseUser> currentUser() async {
    final user = await _auth.currentUser();
    return user;
  }
}
