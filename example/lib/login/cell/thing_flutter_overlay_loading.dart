import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ThingOverlayLoading {
  OverlayEntry? overlayEntry;

  void show(BuildContext context) {
    hidden();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2,
        left: MediaQuery.of(context).size.width / 2,
        child: const CircularProgressIndicator(),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hidden() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  static showToast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3);
  }
}

