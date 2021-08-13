import 'package:flutter/material.dart';
import 'package:super_base_flutter/widgetUtilities/CustomAppBar.dart';
import 'package:super_base_flutter/widgetUtilities/IconContainer.dart';
import '../MainScreen.dart';
import 'HomeNotifier.dart';

class HomeScreen extends MainScreen {
  static const String route_name = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _HomeScreenState extends MainScreenState<HomeNotifier> with WidgetsBindingObserver {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void onKeyboardChange(bool visible) {}

  @override
  String getTitle(BuildContext context) {
    return "Home Title";
  }

  @override
  Widget buildRightComponent(BuildContext context) {
    return IconContainer(
      icon: Icons.notifications_none,
      onTap: () {},
    );
  }

  @override
  void runJustOnceAfterInit() {

  }

  @override
  void onConnectionChange(bool isConnect) {

  }

  @override
  Color getStatusBarColor() {
    return Colors.white;
  }

  @override
  Widget buildChild() {
    return Scaffold(
      appBar: CustomAppBar(component: this, isHome: true, color: getStatusBarColor(),),
      body: Container(
        child: Center(child: Text("Home Test")),
      ),
    );
  }
}
