import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_base_flutter/screens/home/HomeNotifier.dart';
import 'package:super_base_flutter/screens/home/HomeScreen.dart';
import 'package:super_base_flutter/screens/login/LoginNotifier.dart';
import 'package:super_base_flutter/screens/login/LoginScreen.dart';
import 'package:super_base_flutter/screens/splashScreen/SplashNotifier.dart';
import 'package:super_base_flutter/screens/splashScreen/SplashScreen.dart';

/// Khoadd
/// 07/08/2021
///
class MyRouter {
  Route _createRoute(Widget widget, RouteSettings settings, AnimationType type) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        if (type == AnimationType.FADE) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  createRouteList() => (RouteSettings settings) {
        switch (settings.name) {
          case SplashScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => SplashNotifier(), child: SplashScreen()),
                settings, AnimationType.FADE);

          case LoginScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => LoginNotifier(), child: LoginScreen(),),
                settings,
                AnimationType.FADE);

          case HomeScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => HomeNotifier(), child: HomeScreen(),),
                settings,
                AnimationType.SLIDE);
        }
        return null;
        //assert(false);
      };
}

enum AnimationType {
  SLIDE,
  FADE,
}
