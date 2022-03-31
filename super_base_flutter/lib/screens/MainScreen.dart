import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:super_base_flutter/constants/Constants.dart';
import 'package:super_base_flutter/constants/SizeConfig.dart';
import 'package:super_base_flutter/database/Database.dart';
import 'package:super_base_flutter/screens/AppBarComponent.dart';
import 'package:super_base_flutter/services/AppLocalizations.dart';
import 'package:super_base_flutter/services/ConnectionStatusSingleton.dart';
import 'package:super_base_flutter/services/NavigationService.dart';
import 'package:super_base_flutter/services/ServiceLocator.dart';
import 'package:super_base_flutter/utilities/Utilities.dart';

import '../main.dart';
import 'MainNotifier.dart';

/// Khoadd
/// 07/08/2021
///
abstract class MainScreen extends StatefulWidget {
  String getNameScreen();

  @override
  MainScreenState createState();
}

abstract class MainScreenState<T extends MainNotifier> extends State<MainScreen> with AppBarComponent {
  AppLocalizations appLocalizations;
  double heightScreen;
  double widthScreen;
  bool isPortrait;
  T provider;
  KeyboardVisibilityNotification keyboardVisibilityNotification;
  bool isInit = false;

  @override
  String getSubTitle(BuildContext context) {
    return "";
  }

  @override
  Widget buildRightComponent(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeftComponent(BuildContext context) {
    return null;
  }

  @override
  String getTitle(BuildContext context) {
    return "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initValue(context);
  }

  void initValue(BuildContext context) {
    locator<SizeConfig>().init(context);
    appLocalizations = AppLocalizations.of(context);
    heightScreen = SizeConfig.safeBlockVertical * 100;
    widthScreen = SizeConfig.safeBlockHorizontal * 100;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    provider = Provider.of<T>(context, listen: false);
    provider.appLocalizations = appLocalizations;
    provider.arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    provider.db = Provider.of<Database>(context, listen: false);
    provider.parent = MyApp.of(context);
    provider.preferences = provider.parent.preferences;
    provider.currentLang = provider.preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.LANG_DEFAULT;
    provider.context = context;
    if (!isInit) {
      isInit = true;
      provider.navigationService = locator<NavigationService>();
      provider.utilities = locator<Utilities>();
      keyboardVisibilityNotification = KeyboardVisibilityNotification()
        ..addNewListener(
          onChange: onKeyboardChange,
        );
      ConnectionStatusSingleton.getInstance().connectionChange.listen((dynamic result) async {
        bool isConnect = result as bool;
        onConnectionChange(isConnect);
      });
      runJustOnceAfterInit();
    }
  }

  void onKeyboardChange(bool visible);

  void onConnectionChange(bool isConnect) {}

  void runJustOnceAfterInit();

  @override
  Widget build(BuildContext context) {
    provider.utilities.printLog("build ${widget.getNameScreen()}......................................");
    return Container(
        child: Material(child: Container(color: getStatusBarColor(), child: SafeArea(child: buildChild()))));
  }

  Widget buildChild();

  Color getStatusBarColor() {
    return Colors.transparent;
  }

  @override
  void dispose() {
    keyboardVisibilityNotification.dispose();
    super.dispose();
  }
}
