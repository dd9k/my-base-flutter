import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:super_base_flutter/database/Connect.dart';
import 'package:super_base_flutter/services/AppLocalizations.dart';
import 'package:super_base_flutter/services/NavigationService.dart';
import 'package:super_base_flutter/services/ServiceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_base_flutter/themes/AppThemes.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:async';

import 'constants/AppColors.dart';
import 'constants/Constants.dart';
import 'constants/MyRouter.dart';
import 'database/Database.dart';
import 'screens/splashScreen/SplashNotifier.dart';
import 'screens/splashScreen/SplashScreen.dart';
import 'services/ConnectionStatusSingleton.dart';
import 'utilities/Utilities.dart';

/// Khoadd
/// 07/08/2021
///
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  var isOnlineMode = true;
  SharedPreferences preferences;
  var isConnection = true;
  var isPause = false;

  void updateMode() {
    isOnlineMode = isConnection;
  }

  static MyApp of(BuildContext context) {
    return context.findAncestorWidgetOfExactType();
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utilities().printLog("build app......................................");
    ConnectionStatusSingleton.getInstance().connectionChange.listen((dynamic result) {
      if (!result) {
        widget.isConnection = false;
      } else {
        if (!widget.isConnection) {
          widget.isConnection = true;
        }
      }
    });
    return FutureBuilder<String>(
        future: getLanguage(context),
        builder: (widget, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            SpecificLocalizationDelegate _localeOverrideDelegate = SpecificLocalizationDelegate(Locale(snapshot.data));
            return MaterialApp(
              title: 'Base flutter',
              themeMode: ThemeMode.light,
              theme: appThemeData[AppTheme.BlueLight],
              debugShowCheckedModeBanner: false,
              navigatorKey: locator<NavigationService>().navigatorKey,
              home: ChangeNotifierProvider(create: (_) => SplashNotifier(), child: SplashScreen()),
              onGenerateRoute: locator<MyRouter>().createRouteList(),
              supportedLocales: [Locale(Constants.EN_CODE), Locale(Constants.VN_CODE)],
              localizationsDelegates: [
                _localeOverrideDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
            );
          }
          return Material();
        });
  }

  Future<String> getLanguage(BuildContext context) async {
    var isConnection = await Utilities().isConnectInternet(isChangeState: false);
    widget.isOnlineMode = isConnection;
    widget.isConnection = isConnection;
    var completer = Completer<String>();
    widget.preferences = await SharedPreferences.getInstance();
    var lang = widget.preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.LANG_DEFAULT;
    if (lang.isEmpty || !Constants.LIST_LANG.contains(lang)) {
      lang = Constants.LANG_DEFAULT;
    }
    completer.complete(lang);
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void onDeactivate() {
    super.deactivate();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          widget.isPause = false;
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          widget.isPause = true;
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  setupLocator();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.MAIN_TEXT_COLOR,
      statusBarColor: Colors.transparent,
    ),
  );
  Wakelock.enable();
  ConnectionStatusSingleton.getInstance().initialize();
  runApp(MultiProvider(
    providers: [
      Provider(
          create: (BuildContext context) => constructDb(), dispose: (BuildContext context, Database db) => db.close()),
    ],
    child: MyApp(),
  ));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    Utilities().printLog('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
