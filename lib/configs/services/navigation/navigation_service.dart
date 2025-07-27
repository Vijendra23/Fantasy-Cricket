import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationService {
  BuildContext get context;

  abstract final GoRouter router;

  String getCurrentRoute();

  Future<dynamic> pushScreen(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = false,
  });

  void popAndPushScreen(
    String routeName, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? params,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = false,
  });

  void pushReplacementScreen(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  });

  void popAndPushReplacement(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  });

  void goToRoute(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  });



  Future<dynamic> pushDialog(Widget dialog, {bool isDismissible = false});

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? snackBarAction,
    BuildContext? ctx,
  });

  void pop({dynamic sendDataBack, bool useHaptic = true});
}
