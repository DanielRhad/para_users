import 'package:flutter/material.dart';
import 'package:para_users/main.dart';

class ErrorDialog extends StatelessWidget
{
  final String? message;
  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          child: const Center(
            child: Text("OK"),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: ()
          {
            MyApp.restartApp(context);
          },
        ),
      ],
    );
  }
}
