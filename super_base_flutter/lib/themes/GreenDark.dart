import 'package:super_base_flutter/themes/BaseTheme.dart';
import 'package:flutter/material.dart';

final ThemeData greenDarkTheme = _greenDarkTheme().copyWith(inputDecorationTheme: BaseTheme().baseTextField);

ThemeData _greenDarkTheme() {
  return ThemeData(brightness: Brightness.dark, primaryColor: Colors.green[700], fontFamily: "Helvetica");
}
