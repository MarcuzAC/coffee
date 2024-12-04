import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  Future<bool> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showToast('Sign-up successful!');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showToast('An account already exists with that email.');
      } else {
        _showToast('Sign-up failed: ${e.message}');
      }
      return false;
    }
  }

  Future<bool> signin({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _showToast('Sign-in successful!');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showToast('Wrong password provided for that user.');
      } else {
        _showToast('Sign-in failed: ${e.message}');
      }
      return false;
    }
  }

  Future<void> signout({required BuildContext context}) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      _showToast('Sign-out successful!');
    } catch (e) {
      _showToast('Sign-out failed: ${e.toString()}');
    }
  }

  Future<bool> googleSignIn() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _showToast('Google Sign-In cancelled.');
        return false; // User aborted sign-in
      }

      // Obtain authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      await _auth.signInWithCredential(credential);
      _showToast('Google Sign-In successful!');
      return true;
    } catch (e) {
      _showToast('Google Sign-In failed: ${e.toString()}');
      return false;
    }
  }
}
