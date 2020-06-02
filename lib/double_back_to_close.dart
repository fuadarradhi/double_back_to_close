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
  final int waitForSecondBackPress;
  final Function onFirstBackPress;
  final int type;

  /// DoubleBack, wrap a widget to use it
  const DoubleBack({
    Key key,
    @required this.child,
    this.message = "Press back again to exit",
    this.waitForSecondBackPress = 2,
    this.onFirstBackPress,
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
                seconds: widget.waitForSecondBackPress,
              ),
              resetBackTimeout,
            );

            if (widget.onFirstBackPress != null) {
              widget.onFirstBackPress(context);
            } else {
              Toast.show(
                widget.message,
                context,
                duration: widget.waitForSecondBackPress,
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
