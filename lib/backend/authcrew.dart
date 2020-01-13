import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthCrew {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail(
      {@required String email, @required String password}) async {
    try {
      var user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (error) {
      return error.toString();
    }
  }

  Future signUpWithEmail(
      {@required String email, @required String password}) async {
    try {
      var authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user;
    } catch (error) {
      return error.toString();
    }
  }
}
