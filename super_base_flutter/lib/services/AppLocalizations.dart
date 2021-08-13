import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Khoadd
/// 07/08/2021
///
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;
  Map<String, String> _viStrings;
  Map<String, String> _enStrings;

  Future<bool> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  Future<bool> initLocalLang() async {
    if (_viStrings != null) {
      return false;
    }
    String jsonString = await rootBundle.loadString('assets/lang/vi.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _viStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    jsonString = await rootBundle.loadString('assets/lang/en.json');
    jsonMap = json.decode(jsonString);

    _enStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String get noInternet => translate("no_internet");

  String get messageCommonError => translate("message_common_error");

  String get buttonTryAgain => translate("button_try_again");

  String get buttonClose => translate("button_close");

  String get titleError => translate("title_error");

  String get titleNotification => translate("title_notification");

  String get btnYes => translate("btn_yes");

  String get btnNo => translate("btn_no");

  String get btnOk => translate("btn_ok");

  String get noPermission => translate("no_permission");

  String get errorNoEmail => translate("error_no_email");

  String get invalidEmail => translate("invalid_email");

  String get invalidPhone => translate("invalid_phone");

  String translate(String key) {
    return _localizedStrings[key];
  }

  String translateVi(String key) {
    return _viStrings[key];
  }

  String translateEn(String key) {
    return _enStrings[key];
  }
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(overriddenLocale);
    await localizations.load(overriddenLocale);
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
