import 'package:chat_app/modules/register/register_view_model.dart';
import 'package:chat_app/modules/register/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements States {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var userNameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.states = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
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
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text('Create Account'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: keyForm,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            controller: firstNameController,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: lastNameController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Last Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: userNameController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'User Name',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your User Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'Email Not Valid';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: passwordController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              if (text.length < 6) {
                                return 'Password should be at least 6 char';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              RegisterBottonFunction();
                            },
                            child: Text('Create Email'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void RegisterBottonFunction() async {
    if (keyForm.currentState!.validate()) {
      //  create account with firebase
      viewModel.CreateAccount(emailController.text, passwordController.text);
    }
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }

  @override
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
            children: [Expanded(child: Text(message))],
          ));
        });
  }
}