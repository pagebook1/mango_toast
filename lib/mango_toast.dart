library mango_toast;

import 'package:flutter/material.dart';

enum toastPosition { left, right, center }

class MangoToast {
  //check if context is not needed then dispose
  static MangoToastMessage success(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(message, Colors.green, duration, position,Icons.check_circle_sharp);
  }

  static MangoToastMessage error(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(message, Colors.red, duration, position,Icons.error_sharp);
  }

  static MangoToastMessage warning(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(
        message, Colors.deepOrangeAccent, duration, position,Icons.warning_sharp);
  }

  static MangoToastMessage info(String message,
      {Duration duration = const Duration(seconds: 2),
      toastPosition position = toastPosition.center}) {
    return MangoToastMessage(message, Colors.blueAccent, duration, position,Icons.info_sharp);
  }

  // void dispose(BuildContext context) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  // }
}

class MangoToastMessage {
  final String message;
  final Color color;
  final Duration duration;
  final toastPosition position;
  final IconData icon;
  MangoToastMessage(this.message, this.color, this.duration, this.position,this.icon);
  void show(BuildContext context,
      {Duration duration = const Duration(seconds: 2)}) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      final screen_height = MediaQuery.of(context).size.height;
      final screen_width = MediaQuery.of(context).size.width;
      double left = .30;
      double right = .30;
      double top = .15;
      double fontSize = 15;
      // make the left and right padding depends on how long the message is
      if (position == toastPosition.left) {
        left = .05;
        right = .60;
      } else if (position == toastPosition.right) {
        left = .60;
        right = .05;
      }
      if (screen_width < 500) {
        left = .01;
        right = .01;
        top = .20;
        fontSize = 10;
      } else if (screen_width < 800) {
        left = .05;
        right = .05;
        top = .20;
        fontSize = 12;
      } else if (screen_width < 1000) {
        left = .10;
        right = .10;
        top = .20;
        fontSize = 14;
      }
      final scaffold = ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                 Icon(icon,size:fontSize * 2,color: Colors.white,),
            
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              
              Text(message,
                  style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis))
            ]),
            ButtonBar(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    if (context.mounted)
                      ScaffoldMessenger.of(context).clearSnackBars();
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
              bottom:
                  MediaQuery.of(context).size.height - (screen_height * top),
              right: screen_width * right,
              left: screen_width * left),
          padding: EdgeInsets.only(top: screen_height * .005),
        ),
      );
    }

    // scaffold.closed.then((value) => MangoToast().dispose(context));
  }
}
