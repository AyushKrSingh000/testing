// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 📦 Package imports:

/// shows success message toast
showSuccessMessage(BuildContext context, String message) => _showToast(
      message,
      const Color(0XFF40b672),
    );

showSuccessToast(String message) => _showToast(
      message,
      const Color(0XFF40b672),
    );

/// shows error message toast
showErrorMessage(BuildContext context, String message) => _showToast(
      message,
      const Color(0XFFf03560),
      toastLength: message.length > 80 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    );

_showToast(
  String message,
  Color backgroundColor, {
  Toast? toastLength,
}) {
  // remove current toast, if any
  Fluttertoast.cancel();
  // show the snack bar
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: backgroundColor,
    toastLength: toastLength,
  );
}
