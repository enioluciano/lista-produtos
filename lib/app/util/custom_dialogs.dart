import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Future<void> confirmOrRejectDialog(
      {required String title,
      required List<Widget> content,
      required String textConfirm,
      required String textCancel,
      required Function() onPressed}) {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(children: content),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: Get.back,
              style: TextButton.styleFrom(primary: Colors.grey[600]),
              child: Text(textCancel, style: const TextStyle(fontSize: 16.0)),
            ),
            TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(primary: Colors.red),
              child: Text(textConfirm, style: const TextStyle(fontSize: 16.0)),
            )
          ],
        );
      },
    );
  }

  static Future<void> loadDialog({required String text}) {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
              const SizedBox(height: 20),
              Text(text),
            ]),
          ),
        );
      },
    );
  }

  static Future<void> sucessDialog({required String text}) {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              const Icon(
                Icons.check_circle,
                size: 30,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              Text(text),
            ]),
          ),
        );
      },
    );
  }

  static Future<void> errorDialog({required String text}) {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              const Icon(
                Icons.error,
                size: 30,
                color: Colors.red,
              ),
              const SizedBox(height: 20),
              Text(text),
            ]),
          ),
        );
      },
    );
  }
}
