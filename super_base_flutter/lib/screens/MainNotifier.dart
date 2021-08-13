import 'package:flutter/cupertino.dart';
import 'package:super_base_flutter/database/Database.dart';
import 'package:super_base_flutter/services/AppLocalizations.dart';
import 'package:super_base_flutter/services/NavigationService.dart';
import 'package:super_base_flutter/utilities/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

/// Khoadd
/// 07/08/2021
///
abstract class MainNotifier extends ChangeNotifier {
  AppLocalizations appLocalizations;
  NavigationService navigationService;
  Utilities utilities;
  Map<String, dynamic> arguments;
  Database db;
  MyApp parent;
  SharedPreferences preferences;
  BuildContext context;
}
