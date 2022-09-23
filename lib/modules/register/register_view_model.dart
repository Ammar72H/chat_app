import 'package:chat_app/base.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/modules/register/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var firebaseAuth = FirebaseAuth.instance;

  void CreateAccount(String email, String password, String fName, String lName,
      String username) async {
    String? message = null;
    try {
      navigator?.showLoading('Loading...', false);
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoading();
      var user = MyUser(
          id: result.user?.uid ?? '',
          fName: fName,
          lName: lName,
          username: username,
          email: email);
      var UserData = await DataBaseUtils.createDBUser(user);

      navigator?.goToHome(user);
      // navigator?.hideLoading();
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.WEEKPASSWORD) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseErrors.INUSE) {
        message = 'The account already exists for that email.';
      }
      // navigator?.hideLoading();
      if (message != null) {
        navigator?.showMessage(message);
      }
    } catch (e) {
      print(e);
    }
  }
}
