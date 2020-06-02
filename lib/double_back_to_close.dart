import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

/// DoubleBack, wrap a widget to use it
/// child : widget
/// message : to show on toast
/// waitToSecondPressed (optional) if you want to wait longer
class DoubleBack extends StatefulWidget {
  final Widget child;
  final String message;
  final int waitToSecondPressed;
  final Function onFirstBackPressed;
  final int type;

  /// DoubleBack, wrap a widget to use it
  const DoubleBack({
    Key key,
    @required this.child,
    this.message = "Press back again to exit",
    this.waitToSecondPressed = 2,
    this.onFirstBackPressed,
    this.type,
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

            if (widget.onFirstBackPressed != null) {
              widget.onFirstBackPressed(context);
            } else {
              Toast.show(
                widget.message,
                context,
                duration: widget.waitToSecondPressed,
                gravity: Toast.BOTTOM,
              );
            }

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
