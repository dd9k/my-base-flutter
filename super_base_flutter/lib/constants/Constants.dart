

class Constants {
  static const Duration CONNECTION_TIME_OUT = Duration(seconds: 120);
  int indexURL = 1;
  static const List<String> URL_LIST = [URL, URL_VNG, URL_FPT];
  static const String URL = "https://api.checkinpro.vn/";
  static const String URL_VNG = "http://61.28.235.127:5100/";
  static const String URL_FPT = "https://api-demo.checkinpro.vn/";

  static const String STATUS_SUCCESS = "SUCCESS";
  static const String STATUS_FAIL = "FAIL";
  static const String STATUS_FAIL_API = "FAIL_API";
  static const String B500 = "b500";
  static const String B401 = "401";
  static const String B400 = "400";
  static const String B403 = "403";

  static const String KEY_AUTHENTICATE = "authenticate";
  static const String KEY_DEV_MODE = "devmode";
  static const String KEY_LANGUAGE = "lang";

  static const String FIELD_BEARER = "Bearer ";

  static const PNG_ETX = "png";
  static const LIMIT_IMAGE_SIZE = 150000;

  static const String FOLDER_TEMP_AVATAR = "temp/avatar";
  static const String FOLDER_TEMP = "temp";
  static const String FILE_TYPE_IMAGE_AVATAR = "avatar";

  static const List<String> LIST_LANG = [Constants.EN_CODE, Constants.VN_CODE];
  static const VN_CODE = "vi";
  static const EN_CODE = "en";
  static const LANG_DEFAULT = Constants.VN_CODE;
}
