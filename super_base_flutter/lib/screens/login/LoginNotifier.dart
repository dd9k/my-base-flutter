import 'package:super_base_flutter/screens/MainNotifier.dart';
import 'package:super_base_flutter/screens/home/HomeScreen.dart';

class LoginNotifier extends MainNotifier {

  void moveToNext() async {
    navigationService.navigateTo(HomeScreen.route_name, 3);
  }
}
