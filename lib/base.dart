import 'package:flutter/material.dart';

class BaseViewModel<T extends BaseNavigator> extends ChangeNotifier {
  T? navigator = null;
}

abstract class BaseNavigator {
  void showLoading(String message, bool isDissmissable);

  void hideLoading();

  void showMessage(String message);
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  VM initalViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initalViewModel();
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading(String message, bool isDissmissable) {
    showDialog(
        context: context,
        barrierDismissible: isDissmissable,
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
