import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'configs/di/service_locator.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupServiceLocator();
  await sharedPreferencesService.init();
  Future.delayed(const Duration(seconds: 2)).then((value) {
    FlutterNativeSplash.remove();
  });

  runApp(const FantasyCricketApp());
}

class FantasyCricketApp extends StatelessWidget {
  const FantasyCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // minTextAdapt: true,
       // designSize: const Size(375, 812),
        designSize:  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        builder: (_, child) {
          return MaterialApp.router(
            title: 'Fantasy Cricket App',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFFFFC238)),
              useMaterial3: true,
            ),
            routerConfig: navigationService.router,
          );
        });
  }
}
