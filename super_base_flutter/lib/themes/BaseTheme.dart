import 'package:flutter/material.dart';
import 'package:super_base_flutter/constants/Styles.dart';

import '../constants/AppColors.dart';
import '../constants/AppDestination.dart';

class BaseTheme {
  static final BaseTheme _singleton = BaseTheme._internal();

  factory BaseTheme() {
    return _singleton;
  }

  BaseTheme._internal();

  var baseTextField = InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.only(left: 13.0, top: 10, bottom: 10, right: 10),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
        borderSide: new BorderSide(color: AppColor.MAIN_TEXT_COLOR)),
    border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(4),
        ),
        borderSide: new BorderSide(color: AppColor.MAIN_TEXT_COLOR)),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(4),
      ),
      borderSide: new BorderSide(color: AppColor.RED_COLOR),
    ),
    hintStyle: TextStyle(fontSize: 14, color: AppColor.HINT_TEXT_COLOR),
    labelStyle: Styles.formFieldText,
    errorStyle: TextStyle(fontSize: 12),
  );
}
