import 'package:flutter/material.dart';
import 'package:super_base_flutter/constants/AppImage.dart';

import '../MainScreen.dart';
import 'SplashNotifier.dart';

class SplashScreen extends MainScreen {
  static const String route_name = '/';

  @override
  SplashScreenState createState() => SplashScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class SplashScreenState extends MainScreenState<SplashNotifier> {

  @override
  void runJustOnceAfterInit() {
    provider.countDownToNext();
  }

  @override
  void onKeyboardChange(bool visible) {
  }

  @override
  void onConnectionChange(bool isConnect) {

  }

  @override
  Widget buildChild() {
    return Container(
      alignment: Alignment.center,
      child: AppImage.viFlag,
    );
  }
}
