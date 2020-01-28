import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    print('Email $email and Password $password recieved now checking credentials.');
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print('Authentication process completed Here is the :$result');
    FirebaseUser user = result.user;
    print('We got the firebase user :$user with uid as:${user.uid}');
    return user.uid;
  }

  Future<String> signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
    notifyListeners();
  }

  
}
