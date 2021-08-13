import 'package:flutter/material.dart';

/// Khoadd
/// 07/08/2021
///
abstract class AppBarComponent {
  String getTitle(BuildContext context);

  String getSubTitle(BuildContext context);

  Widget buildRightComponent(BuildContext context);

  Widget buildLeftComponent(BuildContext context);
}
