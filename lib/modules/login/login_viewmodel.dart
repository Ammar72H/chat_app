import 'package:chat_app/base.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/modules/login/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../database/database_utils.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var firebaseAuth = FirebaseAuth.instance;

  void login(String email, String password) async {
    String? message = null;
    try {
      navigator?.showLoading('Loading...', false);
      var result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = await DataBaseUtils.readUser(result.user?.uid ?? '');

      if (user == null) {
        message = 'Failed to Sine in , Please try again ...';
      } else {
        navigator?.hideLoading();
        navigator?.goToHome(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.USERNOTFOUND) {
        message = 'No user found for that email.';
      } else if (e.code == FirebaseErrors.WRONGPASS) {
        message = 'Wrong password provided for that user.';
      }
      if (e.code == FirebaseErrors.WEEKPASSWORD) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseErrors.INUSE) {
        message = 'The account already exists for that email.';
      }
      navigator?.hideLoading();
      if (message != null) {
        navigator?.showMessage(message);
      }
    } catch (e) {
      print(e);
    }
  }
}
