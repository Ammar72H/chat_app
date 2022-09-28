import 'package:chat_app/base.dart';
import 'package:chat_app/models/category.dart';
import 'package:chat_app/modules/add_rooms/add_room_view_model.dart';
import 'package:chat_app/modules/add_rooms/room_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'addRoom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends BaseState<AddRoom, AddRoomViewModel>
    implements AddRoomNavigator {
  var roomNameController = TextEditingController();

  var roomDescController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var categories = Category.getCategory();

  late Category selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory = categories[0];
    viewModel.navigator = this;
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
            iconTheme: IconThemeData(color: Colors.white),
            title: Text('Add Room'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Craete New Room',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )),
                    Image.asset('assets/images/room_bg.png'),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      controller: roomNameController,
                      decoration: InputDecoration(labelText: 'Room Name'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: DropdownButton<Category>(
                          underline: SizedBox(),
                          isExpanded: true,
                          value: selectedCategory,
                          items: categories
                              .map((catId) => DropdownMenuItem<Category>(
                                  value: catId,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        catId.image,
                                        height: 35,
                                        width: 60,
                                      ),
                                      Spacer(),
                                      Text(catId.name),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (category) {
                            if (category == null) {
                              return;
                            } else {
                              selectedCategory = category;
                            }
                          }),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16),
                      controller: roomDescController,
                      decoration:
                          InputDecoration(labelText: 'Room Description'),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF3598DB)),
                        ),
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Create Room')),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  validateForm() {
    if (formKey.currentState!.validate() == true) {
      viewModel.createRoom(roomNameController.text, selectedCategory.id,
          roomDescController.text);
    }
  }

  @override
  AddRoomViewModel initalViewModel() {
    return AddRoomViewModel();
  }

  @override
  void roomCreated() {
    showMessage('Room Created Successfully', actionName: 'Ok',
        voidCallback: () {
      hideLoading();
      Navigator.pop(context);
    });
  }
}
