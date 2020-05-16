import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

typedef AlertAction<T> = void Function(T index);

class ResAlert {
  AlertStyle _alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: Duration(milliseconds: 550),
  );

  resAlert({
    context,
    AlertType alertType,
    title,
    desc,
    btnColor,
  }) {
    return Alert(
      context: context,
      style: _alertStyle,
      type: alertType,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          color: btnColor,
          child: Text(
            "ตกลง",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
