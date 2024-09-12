import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

navigateTo(Widget page,
    {bool removeHistory = false, bool isReplacement = false}) {
  final route = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );

  if (isReplacement) {
    return Navigator.pushReplacement(
      navigatorKey.currentContext!,
      route,
    );
  } else {
    return Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      route,
      (route) => !removeHistory,
    );
  }
}

void showToast(String msg) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .showSnackBar(SnackBar(content: Text(msg)));
}
