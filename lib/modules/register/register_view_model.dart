import 'package:chat_app/base.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/modules/register/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var firebaseAuth = FirebaseAuth.instance;

  void CreateAccount(String email, String password) async {
    try {
      navigator?.showLoading('Loading...', false);
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoading();
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.WEEKPASSWORD) {
        navigator?.hideLoading();
        navigator?.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.INUSE) {
        navigator?.hideLoading();
        navigator?.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
