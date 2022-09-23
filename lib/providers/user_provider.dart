import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  initMyUser() async {
    if (firebaseUser != null) {
      user = await DataBaseUtils.readUser(firebaseUser?.uid ?? "");
    }
  }
}
