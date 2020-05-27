import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DoubleBack extends StatefulWidget {
  final Widget child;
  final String message;
  final int waitToSecondPressed;

  const DoubleBack({
    Key key,
    @required this.child,
    @required this.message,
    this.waitToSecondPressed = 2,
  }) : super(key: key);

  @override
  _DoubleBackState createState() => _DoubleBackState();
}

class _DoubleBackState extends State<DoubleBack> {
  bool tapped = false;
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: () async {
          if (tapped) {
            return true;
          } else {
            tapped = true;
            Timer(
              Duration(
                seconds: widget.waitToSecondPressed,
              ),
              resetBackTimeout,
            );

            Toast.show(
              widget.message,
              context,
              duration: 2,
              gravity: Toast.BOTTOM,
            );

            return false;
          }
        },
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  void resetBackTimeout() {
    tapped = false;
  }
}
