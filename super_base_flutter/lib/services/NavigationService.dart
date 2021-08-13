import 'package:flutter/material.dart';

/// Khoadd
/// 07/08/2021
///
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const List<String> timeOutRoute = [];

  Future<dynamic> navigateTo<T extends ChangeNotifier>(String routeName, int type, {Object arguments}) {
    switch (type) {
      case 1:
        {
          return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
        }
      case 2:
        {
          return navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
        }
      case 3:
        {
          return navigatorKey.currentState
              .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
        }
    }
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil<T extends ChangeNotifier>(String routeName, String endRoute,
      {Object arguments}) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(endRoute), arguments: arguments);
  }

  void navigatePop(BuildContext context, {Object arguments}) {
    return navigatorKey.currentState.pop(arguments);
  }
}
