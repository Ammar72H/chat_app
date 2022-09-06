import 'package:chat_app/constant.dart';
import 'package:chat_app/modules/register/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late States states;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void CreateAccount(String email, String password) async {
    try {
      states.showLoading();
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      states.hideLoading();
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.WEEKPASSWORD) {
        states.hideLoading();
        states.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.INUSE) {
        states.hideLoading();
        states.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
