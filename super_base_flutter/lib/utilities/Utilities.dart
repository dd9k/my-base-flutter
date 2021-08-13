import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_base_flutter/constants/Constants.dart';
import 'package:super_base_flutter/database/Database.dart';
import 'package:super_base_flutter/model/Authenticate.dart';
import 'package:super_base_flutter/model/ImageDownloaded.dart';
import 'package:super_base_flutter/services/AppLocalizations.dart';
import 'package:super_base_flutter/services/ConnectionStatusSingleton.dart';
import 'package:super_base_flutter/services/NavigationService.dart';
import 'package:super_base_flutter/services/ServiceLocator.dart';
import 'package:super_base_flutter/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// flutter packages pub run build_runner watch --delete-conflicting-outputs
/// flutter build appbundle
/// ./adb logcat > logcard01.txt

/// Khoadd
/// 07/08/2021
///
class Utilities {
  static final Utilities _singleton = locator<Utilities>();

  factory Utilities() {
    return _singleton;
  }

  Utilities.init();

  /// common functions
  Future<bool> isConnectInternet({@required bool isChangeState}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      printLog("Connection: false");
      return false;
    }
    return await ConnectionStatusSingleton.getInstance().checkConnection(isChangeState: isChangeState);
  }

  void printLog(String mess) {
    if (kDebugMode) {
      print(DateTime.now().toString() + ": " + mess);
    }
  }

  Future<void> doLogout(BuildContext context, CancelableOperation cancelableOperation) async {
    /// TODO
  }

  void popupAndSignOut(BuildContext context, CancelableOperation cancelableLogout, String message) {
    var timer = Timer(Duration(seconds: 10), () {
      locator<NavigationService>().navigatePop(context);
      doLogout(context, cancelableLogout);
    });
    Utilities().showOneButtonDialog(
      context,
      DialogType.INFO,
      null,
      AppLocalizations.of(context).titleNotification,
      message,
      AppLocalizations.of(context).btnOk,
      () async {
        timer.cancel();
        doLogout(context, cancelableLogout);
      },
    );
  }

  Future<DateTime> getDateTimeNow(bool isConnection) async {
    if (isConnection) {
      return await NTP.now();
    } else {
      return DateTime.now();
    }
  }

  String getToken(SharedPreferences sharedPreferences) {
    var authentication = sharedPreferences.getString(Constants.KEY_AUTHENTICATE) ?? "";
    var token = Authenticate.fromJson(json.decode(authentication)).accessToken;
    return Constants.FIELD_BEARER + token;
  }

  Future<String> getTokenNotBearer(SharedPreferences sharedPreferences) async {
    var authentication = sharedPreferences.getString(Constants.KEY_AUTHENTICATE) ?? "";
    var token = Authenticate.fromJson(json.decode(authentication)).accessToken;
    return token;
  }

  ///****************************************************************************************************************
  ///
  ///*** get image online and save to local
  Future<Uint8List> saveNetworkImage(String link, String fileName, Database db) async {
    try {
      Uint8List byteImage = await networkImageToByte(link);
      File fileSaved = await saveLocalFile(Constants.FOLDER_TEMP_AVATAR, fileName, null, byteImage);
      List<String> paths = fileSaved?.path?.split("${Constants.FILE_TYPE_IMAGE_AVATAR}/");
      String realLink = link.split("?temp_url_sig").first;
      await db.imageDownloadedDAO.insert(ImageDownloaded(realLink, paths?.last));
      return byteImage;
    } catch (_) {
      return null;
    }
  }

  Future<Uint8List> getSavedNetworkImage(String link, String fileName, Database db) async {
    try {
      String realLink = link?.split("?temp_url_sig")?.first;
      if (realLink == null || realLink.isEmpty) {
        return null;
      }
      ImageDownloaded imageSaved = await db.imageDownloadedDAO.getByLink(realLink);
      if (imageSaved == null || imageSaved.localPath == null) {
        return saveNetworkImage(link, fileName, db);
      }
      String name = imageSaved?.localPath;
      String localPath = await getLocalPathFile(Constants.FOLDER_TEMP, name, null);
      return File(localPath).readAsBytes();
    } catch (_) {
      return null;
    }
  }

  ///****************************************************************************************************************
  ///
  ///*** show dialog

  void showOneButtonDialog(BuildContext context, DialogType type, int autoHide, String title, String content,
      String textButton, Function callBack,
      {Function callbackDismiss}) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: type,
        customHeader: null,
        animType: AnimType.SCALE,
        title: title,
        desc: content,
        autoHide: autoHide,
        dismissOnTouchOutside: false,
        btnOkText: textButton,
        btnOkOnPress: callBack,
        callBackWhenHide: callBack,
        onDissmissCallback: callbackDismiss)
      ..show();
  }

  void showTwoButtonDialog(BuildContext context, DialogType type, int autoHide, String title, String content,
      String textLeft, String textRight, Function leftCallback, Function rightCallBack) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: type,
        animType: AnimType.SCALE,
        title: title,
        desc: content,
        autoHide: autoHide,
        dismissOnTouchOutside: false,
        btnOkText: textRight,
        isDense: true,
        btnOkOnPress: rightCallBack,
        btnCancelText: textLeft,
        callBackWhenHide: leftCallback,
        btnCancelOnPress: leftCallback)
      ..show();
  }

  ///****************************************************************************************************************
  ///
  ///*** save and get file local

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    return File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<File> saveLocalFile(String folderName, String name, String extension, List<int> file) async {
    try {
      final path = await localPath(folderName);
      var pathFile = (extension == null) ? ('$path/$name') : ('$path/$name.$extension');
      var fileSave = new File(pathFile.replaceAll(" ", "_"));
      // Write the file
      return await fileSave.writeAsBytes(file);
    } catch (e) {
      locator<Utilities>().printLog(e.toString());
      return null;
    }
  }

  Future<File> saveLocalFileWithPath(String path, List<int> file) async {
    try {
      var fileSave = new File(path);
      // Write the file
      return await fileSave.writeAsBytes(file);
    } catch (e) {
      locator<Utilities>().printLog(e);
      return null;
    }
  }

  Future<String> localPath(String folderName) async {
    Directory root;
    if (Platform.isAndroid) {
      root = await getApplicationSupportDirectory();
    } else {
      root = await getApplicationDocumentsDirectory();
    }
    if (folderName == null || folderName.isEmpty) {
      return root.path;
    }
    Directory directory = Directory("${root.path}/$folderName");
    if (!(await directory.exists())) {
      directory.create();
    }
    return directory.path;
  }

  Future<File> getLocalFile(String folderName, String name, String extension) async {
    try {
      final path = await localPath(folderName);
      return (extension == null) ? File('$path/$name') : File('$path/$name.$extension');
    } catch (e) {
      Utilities().printLog(e);
      return null;
    }
  }

  Future<String> getLocalPathFile(String folderName, String name, String extension) async {
    final path = await localPath(folderName);
    return (extension == null) ? '$path/$name' : '$path/$name.$extension';
  }

  Future<List<int>> rotateAndResize(String path) async {
    var file = File(path);
    List<int> imageBytes = file.readAsBytesSync();
    if (imageBytes.length > Constants.LIMIT_IMAGE_SIZE) {
      int percent = ((Constants.LIMIT_IMAGE_SIZE / imageBytes.length) * 100).toInt();
      imageBytes = await FlutterImageCompress.compressWithList(imageBytes, quality: percent, keepExif: true);
      await locator<Utilities>().saveLocalFileWithPath(path, imageBytes);
    }
    var image = await FlutterExifRotation.rotateImage(path: path);
    List<int> newBytes = image.readAsBytesSync();
    return newBytes;
  }

  ///****************************************************************************************************************

}
