import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/modules/add_rooms/room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void createRoom(String title, String catId, String desc) async {
    navigator?.showLoading('Creating Room...', false);
    String? message = null;
    try {
      var result = await DataBaseUtils.createRoom(title, catId, desc);
    } catch (e) {
      message = e.toString();
      message = 'something went wrong';
    }
    navigator?.hideLoading();
    if (message != null) {
      navigator?.showMessage(message);
    } else {
      navigator?.roomCreated();
    }
  }
}
