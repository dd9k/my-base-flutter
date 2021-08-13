import 'dart:async';

import 'package:super_base_flutter/constants/Constants.dart';
import 'package:super_base_flutter/screens/login/LoginScreen.dart';
import '../MainNotifier.dart';

class SplashNotifier extends MainNotifier {
  var isRequestDone = false;
  var isCountDownDone = false;

  void initURL() {
    var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
    Constants().indexURL = index;
  }

  void countDownToNext() {
    initURL();
    Timer(Duration(milliseconds: 1000), () {
      moveToNext();
    });
  }

  void moveToNext() async {
    navigationService.navigateTo(LoginScreen.route_name, 3);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
