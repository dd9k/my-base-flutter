import 'package:flutter/material.dart';
import 'package:super_base_flutter/constants/Styles.dart';
import 'package:super_base_flutter/widgetUtilities/CustomAppBar.dart';
import '../MainScreen.dart';
import 'LoginNotifier.dart';

class LoginScreen extends MainScreen {
  static const String route_name = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _LoginScreenState extends MainScreenState<LoginNotifier> with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void onKeyboardChange(bool visible) {}

  @override
  void runJustOnceAfterInit() {}

  @override
  Widget buildChild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("Login Test"),
        RaisedButton(
            onPressed: () {
              provider.moveToNext();
            },
            child: Text(appLocalizations.btnOk, style: Styles.formFieldText,))
      ],
    );
  }
}
