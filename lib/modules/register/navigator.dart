import 'package:chat_app/base.dart';
import 'package:chat_app/models/my_user.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome(MyUser user);
}
