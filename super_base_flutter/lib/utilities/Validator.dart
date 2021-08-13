import 'package:super_base_flutter/services/AppLocalizations.dart';

/// Khoadd
/// 07/08/2021
///
class Validator {
  AppLocalizations appLocalizations;

  Validator(this.appLocalizations);

  static const String patternEmail = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";

  static const String patternPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  String validateEmail(String value) {
    if (value.isNotEmpty) {
      RegExp regExp = new RegExp(patternEmail);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return appLocalizations.invalidEmail;
    }
    return appLocalizations.errorNoEmail;
  }

  String phoneNumberValidator(String value) {
    RegExp regex = new RegExp(patternPhone);
    if (!regex.hasMatch(value))
      return appLocalizations.invalidPhone;
    else
      return null;
  }
}
