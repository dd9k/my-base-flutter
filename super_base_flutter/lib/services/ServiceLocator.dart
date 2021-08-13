import 'package:get_it/get_it.dart';
import 'package:super_base_flutter/constants/AppDestination.dart';
import 'package:super_base_flutter/constants/Constants.dart';
import 'package:super_base_flutter/constants/MyRouter.dart';
import 'package:super_base_flutter/constants/SizeConfig.dart';
import 'package:super_base_flutter/services/NavigationService.dart';
import 'package:super_base_flutter/utilities/Utilities.dart';
/// Khoadd
/// 07/08/2021
///
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppDestination());
  locator.registerLazySingleton(() => Utilities.init());
  locator.registerLazySingleton(() => Constants());
  locator.registerLazySingleton(() => SizeConfig());
  locator.registerLazySingleton(() => MyRouter());
  locator.registerLazySingleton(() => NavigationService());
}
