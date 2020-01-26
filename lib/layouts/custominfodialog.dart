import 'package:flutter/material.dart';

class CustomInfoDialog {
  void showInfoDialog({String title, String message, context}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(message, textAlign: TextAlign.center),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.brown[800]),
        ),
        actions: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(bottom: 20, right: 20),
            child: Text('Okay',
                style: TextStyle(color: Colors.brown[800], fontSize: 20)),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }
}
