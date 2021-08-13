import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class AppImage {
  static var viFlag = Image.asset(
    "assets/images/vi_flag.png",
    cacheWidth: 161 * SizeConfig.devicePixelRatio,
    cacheHeight: 161 * SizeConfig.devicePixelRatio,
  );
}
