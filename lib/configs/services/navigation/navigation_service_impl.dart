import 'dart:io';
import 'package:fantasy_cricket_app/feature/auth/presentation/login/login_screen.dart';
import 'package:fantasy_cricket_app/feature/auth/presentation/login_with_username/login_with_username_screen.dart';
import 'package:fantasy_cricket_app/feature/auth/presentation/otp_screen/otp_screen.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/create_team/create_team_screen.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/preview_team/preview_team_screen.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/select_captain/select_captain_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/data_source/shared_preferences/preference_key.dart';
import '../../di/service_locator.dart';
import 'navigation_service.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppNavigationServiceImpl extends NavigationService {
  @override
  BuildContext get context =>
      router.routeInformationParser.configuration.navigatorKey.currentContext!;

  bool get contextNotNull =>
      router.routeInformationParser.configuration.navigatorKey.currentContext !=
      null;

  @override
  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: LoginScreen.route.path,
    routes: [
     GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: LoginScreen.route.path,
        name: LoginScreen.route.name,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
        redirect: (context, state) async {
           final isLoggedIn = await sharedPreferencesService.getBoolean(PreferenceKeys.isUserLoggedIn);
          if (isLoggedIn) {
            return CreateTeamScreen.route.path;
          }
          return null;
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: OtpScreen.route.path,
        name: OtpScreen.route.name,
        pageBuilder: (context, state) {
          var mobile = '';
          final extras = state.extra as Map<String, dynamic>;
          if (extras.keys.contains('mobile')) {
            mobile = extras['mobile'];
          }
          return MaterialPage(
            child: OtpScreen(mobileNumber: mobile),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: LoginWithUsernameScreen.route.path,
        name: LoginWithUsernameScreen.route.name,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginWithUsernameScreen(),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: CreateTeamScreen.route.path,
        name: CreateTeamScreen.route.name,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CreateTeamScreen(),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: SelectCaptainScreen.route.path,
        name: SelectCaptainScreen.route.name,
        pageBuilder: (context, state) {
          var team;
          final extras = state.extra as Map<String, dynamic>;
          if (extras.keys.contains('team')) {
            team = extras['team'];
          }
          return MaterialPage(
            child: SelectCaptainScreen(team: team),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: PreviewTeamScreen.route.path,
        name: PreviewTeamScreen.route.name,
        pageBuilder: (context, state) {
          var team;
          final extras = state.extra as Map<String, dynamic>;
          if (extras.keys.contains('team')) {
            team = extras['team'];
          }
          return MaterialPage(
            child: PreviewTeamScreen(team: team),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Container(),
      );
    },
  );

  @override
  String getCurrentRoute() {
    final lastMatch = router.routerDelegate.currentConfiguration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final location = matchList.uri.toString();
    return location;
  }

  @override
  Future<dynamic> pushScreen(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  }) {
    if (makeHapticFeedback) {
      HapticFeedback.selectionClick();
    }
    ScaffoldMessenger.of(navigationService.context).hideCurrentSnackBar();
    return router.pushNamed(
      routeName,
      queryParameters: queryParameters ?? <String, dynamic>{},
      pathParameters: pathParameters ?? <String, String>{},
      extra: extra ?? <String, dynamic>{},
    );
  }

  @override
  void pushReplacementScreen(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  }) {
    if (makeHapticFeedback) {
      HapticFeedback.selectionClick();
    }
    ScaffoldMessenger.of(navigationService.context).hideCurrentSnackBar();
    router.pushReplacementNamed(
      routeName,
      queryParameters: queryParameters ?? <String, dynamic>{},
      pathParameters: pathParameters ?? <String, String>{},
      extra: extra ?? <String, dynamic>{},
    );
  }

  @override
  void popAndPushReplacement(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  }) {
    router.pop();
    pushReplacementScreen(
      routeName,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
      extra: extra,
      makeHapticFeedback: makeHapticFeedback,
    );
  }

  @override
  void goToRoute(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = true,
  }) {
    if (makeHapticFeedback) {
      HapticFeedback.selectionClick();
    }
    ScaffoldMessenger.of(navigationService.context).hideCurrentSnackBar();
    router.goNamed(
      routeName,
      queryParameters: queryParameters ?? <String, dynamic>{},
      pathParameters: pathParameters ?? <String, String>{},
      extra: extra ?? <String, dynamic>{},
    );
  }

  @override
  Future<dynamic> pushDialog(Widget dialog, {bool isDismissible = false}) {
    return Platform.isAndroid
        ? showDialog(
            context: router.routeInformationParser.configuration.navigatorKey
                .currentContext!,
            barrierDismissible: isDismissible,
            builder: (BuildContext context) {
              return dialog;
            },
          )
        : showCupertinoDialog(
            context: router.routeInformationParser.configuration.navigatorKey
                .currentContext!,
            barrierDismissible: isDismissible,
            builder: (BuildContext context) {
              return dialog;
            },
          );
  }

  @override
  void showSnackBar(String message,
      {Duration duration = const Duration(seconds: 3),
      SnackBarAction? snackBarAction,
      BuildContext? ctx,
      Color bgColor = Colors.black}) {
    final context = ctx ??
        router
            .routeInformationParser.configuration.navigatorKey.currentContext!;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor,
          behavior: SnackBarBehavior.floating,
          duration: duration,
          content: Text(message),
          action: snackBarAction,
        ),
      );
  }

  @override
  void pop({dynamic sendDataBack, bool useHaptic = true}) {
    if (router.canPop()) {
      router.pop(sendDataBack);
    }
    ScaffoldMessenger.of(navigationService.context).hideCurrentSnackBar();
    if (useHaptic) {
      HapticFeedback.selectionClick();
    }
  }

  @override
  void popAndPushScreen(
    String routeName, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? params,
    Map<String, dynamic>? extra,
    bool makeHapticFeedback = false,
  }) {
    router.pop();
    pushScreen(
      routeName,
      queryParameters: queryParams,
      pathParameters: params,
      extra: extra,
      makeHapticFeedback: makeHapticFeedback,
    );
  }

  void refreshRoute() {
    router.refresh();
  }
}

class RouteDetails {
  RouteDetails(this.name, this.path);

  final String name;
  final String path;
}
