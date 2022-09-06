import 'package:flutter/material.dart';

showLoading(BuildContext context, String text, {bool isCancelable = true}) {
  showDialog(
      barrierDismissible: isCancelable,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        );
      });
}

hideLoadingDilog(BuildContext context) {
  Navigator.pop(context);
}

showMessage(
  BuildContext context,
  String message,
  String actionName,
  VoidCallback actionCallBack, {
  bool isCancelable = true,
  String? NegActionName,
  VoidCallback? NagActionCallBack,
}) {
  List<Widget> actions = [
    TextButton(
        onPressed: () {
          actionCallBack();
        },
        child: Text(actionName)),
  ];
  if (NegActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          if (NagActionCallBack != null) NagActionCallBack();
        },
        child: Text(NegActionName)));
  }
  showDialog(
      barrierDismissible: isCancelable,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Text(
            message,
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: actions,
        );
      });
}
