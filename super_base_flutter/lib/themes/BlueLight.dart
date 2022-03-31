import 'package:super_base_flutter/constants/Styles.dart';
import 'package:super_base_flutter/themes/BaseTheme.dart';
import 'package:flutter/material.dart';

import '../constants/AppColors.dart';

final ThemeData blueLightTheme = _blueLightTheme().copyWith(inputDecorationTheme: BaseTheme().baseTextField);

ThemeData _blueLightTheme() {
  return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.MAIN_TEXT_COLOR,
      fontFamily: Styles.Helvetica,
      textTheme: TextTheme(
          headline1: TextStyle(fontFamily: Styles.Helvetica, fontSize: 22, height: 1.25, color: Colors.black),
          headline2: TextStyle(fontFamily: Styles.Helvetica, fontSize: 18, height: 1.25, color: Colors.black),
          headline3: TextStyle(fontFamily: Styles.Helvetica, fontSize: 16, height: 1.25, color: Colors.black),
          bodyText1: TextStyle(fontFamily: Styles.Helvetica, fontSize: 14, height: 1.25, color: Colors.black),
          bodyText2: TextStyle(fontFamily: Styles.Helvetica, fontSize: 12, height: 1.25, color: Colors.black)));
}
