import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GoogleSignInController {

  User? user;

  Future<void> sigInWithGoogle() async {
    try {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Entrando...',
          message: 'Entrar com Google',
          duration: Duration(seconds: 3),
        ),
      );
      final GoogleSignIn googleSignIn = await GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
      user = authResult.user;

      if (user != null) {
        Get.offNamed('/navigation');
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Erro ao entrar',
          message: 'Tente novamente',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

