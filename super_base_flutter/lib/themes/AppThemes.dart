import 'package:super_base_flutter/themes/BlueDark.dart';
import 'package:super_base_flutter/themes/BlueLight.dart';
import 'package:super_base_flutter/themes/GreenDark.dart';
import 'package:super_base_flutter/themes/GreenLight.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark,
}

final appThemeData = {
  AppTheme.GreenLight: greenLightTheme,
  AppTheme.GreenDark: greenDarkTheme,
  AppTheme.BlueLight: blueLightTheme,
  AppTheme.BlueDark: blueDarkTheme,
};
