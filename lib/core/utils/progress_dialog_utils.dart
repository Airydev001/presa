import 'package:flutter/material.dart';

import 'package:presa/core/app_export.dart';

class ProgressDialogUtils {
  static bool isProgressVisible = false;

  static void showProgressDialog(
      {BuildContext? context, isCanncellable = false}) async {
    if (!isProgressVisible &&
        NavigatorService.navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
          context: NavigatorService.navigatorKey.currentState!.overlay!.context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          });
      isProgressVisible = true;
    }
  }

  static void hideProgressDialog() {
    if (isProgressVisible) {
      Navigator.pop(
          NavigatorService.navigatorKey.currentState!.overlay!.context);
      isProgressVisible = false;
    }
  }
}
