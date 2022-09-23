import 'package:chat_app/modules/add_rooms/add_room.dart';
import 'package:chat_app/modules/hame/home.dart';
import 'package:chat_app/modules/login/login_screen.dart';
import 'package:chat_app/modules/register/register.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/shared/styles/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoom.routeName: (context) => AddRoom(),
      },
      theme: MyThemeData.lightTheme,
    );
  }
}
