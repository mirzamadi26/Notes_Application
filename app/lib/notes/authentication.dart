import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> googleSignin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential usercredential =
            await _auth.signInWithCredential(credential);
        return usercredential.user;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future googlesignout() async {
    GoogleSignIn signout = GoogleSignIn();
    await signout.signOut();
  }
}
