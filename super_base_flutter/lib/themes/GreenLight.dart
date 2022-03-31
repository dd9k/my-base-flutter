import 'package:super_base_flutter/themes/BaseTheme.dart';
import 'package:flutter/material.dart';

final ThemeData greenLightTheme = _greenLightTheme().copyWith(
  inputDecorationTheme: BaseTheme().baseTextField,
);

ThemeData _greenLightTheme() {
  return ThemeData(brightness: Brightness.light, primaryColor: Colors.green, fontFamily: "Helvetica");
}
