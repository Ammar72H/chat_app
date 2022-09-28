import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/modules/hame/navigator.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void getRooms() async {
    rooms = await DataBaseUtils.getRoomsFromFireStore();
  }
}
