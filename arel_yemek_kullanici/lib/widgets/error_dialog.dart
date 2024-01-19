import 'package:flutter/material.dart';
class ErrorDialog extends StatelessWidget {


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
            child: Text("TAMAM"),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: ()
            {
              Navigator.pop(context);
            }
        )
      ],
    );
  }
}
