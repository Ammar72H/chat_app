import 'package:chat_app/base.dart';
import 'package:chat_app/modules/login/login_viewmodel.dart';
import 'package:chat_app/modules/login/navigator.dart';
import 'package:chat_app/modules/register/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  var keyForm = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            title: Text('Log In'),
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
                            LoginBottonFunction();
                          },
                          child: Text('Log In'),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: Text(
                                'Don’t Have An Account',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              )),
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
    );
  }

  void LoginBottonFunction() {
    if (keyForm.currentState!.validate() == true) {
      //  please login
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  LoginViewModel initalViewModel() {
    return LoginViewModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }
}
