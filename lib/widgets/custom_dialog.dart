import 'dart:io';

import 'package:dicoding_news_app/common/navigations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Coming soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigation.back();
              },
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Coming soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigation.back();
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }
}
