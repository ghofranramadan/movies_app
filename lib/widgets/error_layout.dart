import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPopUp extends StatelessWidget {
  final String message;
  final String title;
  final Function onTap;

  ErrorPopUp({required this.message, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 24.0),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 36.0),
          RaisedButton(
            color: Theme.of(context).buttonColor,
            onPressed: () {
              onTap;
            },
            child: Text(
              "Try Again",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
