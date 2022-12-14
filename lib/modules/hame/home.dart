import 'package:chat_app/base.dart';
import 'package:chat_app/modules/hame/home_view_model.dart';
import 'package:chat_app/modules/hame/navigator.dart';
import 'package:chat_app/modules/hame/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_rooms/add_room.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          child: Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('Chat App'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoom.routeName);
            },
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<HomeViewModel>(
                    builder: (c, vm, child) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: vm.rooms.length,
                          itemBuilder: (context, index) {
                            return RoomWidget(vm.rooms[index]);
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  HomeViewModel initalViewModel() => HomeViewModel();
}
