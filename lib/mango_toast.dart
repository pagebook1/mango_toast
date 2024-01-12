library mango_toast;

import 'package:flutter/material.dart';

enum toastPosition { left, right, center }

class MangoToast {
  //check if context is not needed then dispose
  static MangoToastMessage success(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(message, Colors.green, duration, position);
  }

  static MangoToastMessage error(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(message, Colors.red, duration, position);
  }

  static MangoToastMessage warning(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(
        message, Colors.deepOrangeAccent, duration, position);
  }

  void dispose(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}

class MangoToastMessage {
  final String message;
  final Color color;
  final Duration duration;
  final toastPosition position;
  MangoToastMessage(this.message, this.color, this.duration, this.position);
  void show(BuildContext context,
      {Duration duration = const Duration(seconds: 2)}) {
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    double left = .30;
    double right = .30;
    double top = .15;
    if (position == toastPosition.left) {
      left = .05;
      right = .60;
    } else if (position == toastPosition.right) {
      left = .60;
      right = .05;
    }
    if(screen_width < 500){
      left = .01;
      right = .01;
      top = .20;
    }
    final scaffold = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(padding: EdgeInsets.only(left: screen_width * .001)),
          Text(message, style: const TextStyle(color: Colors.white)),
          ButtonBar(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ]),
        backgroundColor: color,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        closeIconColor: Colors.white,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - (screen_height * top),
            right: screen_width * right,
            left: screen_width * left),
        padding: EdgeInsets.only(top: screen_height * .005),
      ),
    );

    scaffold.closed.then((value) => MangoToast().dispose(context));
  }
}
