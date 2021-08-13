import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:super_base_flutter/constants/Constants.dart';
import 'package:super_base_flutter/model/BaseListResponse.dart';
import 'package:super_base_flutter/model/BaseResponse.dart';
import 'package:super_base_flutter/utilities/Utilities.dart';
import 'package:super_base_flutter/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_base_flutter/model/Errors.dart';
import 'package:super_base_flutter/services/AppLocalizations.dart';

import 'ApiCallBack.dart';
import 'ApiService.dart';
import 'MobileDataInterceptor.dart';
import 'ServiceLocator.dart';

/// Khoadd
/// 07/08/2021
///
enum ApiServicePut {
  PUT_API,
}

enum ApiServiceDelete {
  DELETE_API,
}

enum ApiServicePost { POST_API, POST_API_NO_AUTHENTICATE, PUT_API }

enum ApiServiceUpload { POST_FILE_ID, POST_FILE_JSON, POST_AVATAR }

enum ApiServiceGet {
  GET_API_WITHOUT_TOKEN,
  GET_API_WITH_PATH,
}

enum ResponseType {
  OBJECT,
  LIST,
  FILE,
}

class ApiRequest {
  static final ApiRequest _singleton = ApiRequest._internal();
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;

  factory ApiRequest() {
    return _singleton;
  }

  static const listNoneInternet = [];

  ApiRequest._internal();

  Future<CancelableOperation<dynamic>> createPutService(
      BuildContext context,
      ApiServicePut apiServiceType,
      ResponseType responseType,
      String path,
      Map<String, dynamic> body,
      ApiCallBack apiCallBack,
      Function doAgain) async {
    var token = "";
    if (apiServiceType == ApiServicePut.PUT_API) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = locator<Utilities>().getToken(preferences);
    }
    Future<dynamic> apiService;
    switch (apiServiceType) {
      case ApiServicePut.PUT_API:
        apiService = ApiService.create().putAPI(path, token, body);
        break;
    }
    var cancelable = CancelableOperation.fromFuture(
      apiService,
      onCancel: () => {},
    );
    return cancelable
      ..value.then((dynamic response) async {
        await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
      }, onError: (response) async {
        await handlerOnError(response, path, context, apiCallBack, doAgain, responseType);
      }).catchError((error, stackTrace) {
        handlerCatchError(error, path, context, apiCallBack, doAgain);
      });
  }

  Future handlerOnError(response, String path, BuildContext context, ApiCallBack apiCallBack, Function doAgain,
      ResponseType responseType) async {
    if (response is MobileException) {
      var isContain = false;
      for (var pathNone in listNoneInternet) {
        if (path.contains(pathNone)) {
          isContain = true;
        }
      }
      if (!isContain) {
        showNoInternet(context, apiCallBack, doAgain);
      } else {
        var errors = Errors(-2, AppLocalizations.of(context).messageCommonError);
        apiCallBack.onError(errors);
      }
    } else {
      await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
    }
  }

  void handlerCatchError(error, String path, BuildContext context, ApiCallBack apiCallBack, Function doAgain) {
    try {
      var message = error.toString();
      if (message.contains("MobileException")) {
        if (!listNoneInternet.contains(path)) {
          showNoInternet(context, apiCallBack, doAgain);
        } else {
          var errors = Errors(-2, AppLocalizations.of(context).messageCommonError);
          apiCallBack.onError(errors);
        }
      } else {
        handlerError(context, apiCallBack, message);
      }
    } catch (e) {
      Utilities().printLog(e.toString());
      var errors = Errors(-1001, "Something when wrong! Please restart app or contact administrator");
      apiCallBack.onError(errors);
    }
  }

  Future<CancelableOperation<dynamic>> createPostService(
      BuildContext context,
      ApiServicePost apiServiceType,
      ResponseType responseType,
      String path,
      Map<String, dynamic> body,
      ApiCallBack apiCallBack,
      Function doAgain) async {
    var token = "";
    if (apiServiceType != ApiServicePost.POST_API_NO_AUTHENTICATE) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = locator<Utilities>().getToken(preferences);
    }
    Future<dynamic> apiService;
    switch (apiServiceType) {
      case ApiServicePost.POST_API:
        {
          apiService = ApiService.create().postApi(path, token, body);
          break;
        }
      case ApiServicePost.POST_API_NO_AUTHENTICATE:
        {
          apiService = ApiService.create().postApiNoAuthenticate(path, body);
          break;
        }
      case ApiServicePost.PUT_API:
        {
          apiService = ApiService.create().putAPI(path, token, body);
          break;
        }
    }
    var cancelable = CancelableOperation.fromFuture(
      apiService,
      onCancel: () => {},
    );
    return cancelable
      ..value.then((dynamic response) async {
        await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
      }, onError: (response) async {
        handlerOnError(response, path, context, apiCallBack, doAgain, responseType);
      }).catchError((error, stackTrace) {
        handlerCatchError(error, path, context, apiCallBack, doAgain);
      });
  }

  Future<CancelableOperation<dynamic>> createDeleteService(BuildContext context, ApiServiceDelete apiServiceType,
      ResponseType responseType, String path, ApiCallBack apiCallBack, Function doAgain) async {
    var token = "";
    if (apiServiceType == ApiServiceDelete.DELETE_API) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = locator<Utilities>().getToken(preferences);
    }
    Future<dynamic> apiService;
    switch (apiServiceType) {
      case ApiServiceDelete.DELETE_API:
        apiService = ApiService.create().deleteAPI(path, token);
        break;
    }
    var cancelable = CancelableOperation.fromFuture(
      apiService,
      onCancel: () => {},
    );
    return cancelable
      ..value.then((dynamic response) async {
        await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
      }, onError: (response) async {
        handlerOnError(response, path, context, apiCallBack, doAgain, responseType);
      }).catchError((error, stackTrace) {
        handlerCatchError(error, path, context, apiCallBack, doAgain);
      });
  }

  Future<CancelableOperation<dynamic>> createGetService(BuildContext context, ApiServiceGet apiServiceType,
      ResponseType responseType, String path, ApiCallBack apiCallBack, Function doAgain) async {
    var token = "";
    if (apiServiceType != ApiServiceGet.GET_API_WITHOUT_TOKEN) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = locator<Utilities>().getToken(preferences);
    }
    Future<dynamic> apiService;
    switch (apiServiceType) {
      case ApiServiceGet.GET_API_WITHOUT_TOKEN:
        {
          apiService = ApiService.create().getAPIWithoutToken(path);
          break;
        }
      case ApiServiceGet.GET_API_WITH_PATH:
        {
          apiService = ApiService.create().getAPIWithPath(path, token);
          break;
        }
    }
    var cancelable = CancelableOperation.fromFuture(
      apiService,
      onCancel: () => {},
    );

    return cancelable
      ..value.then((dynamic response) async {
        await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
      }, onError: (response) async {
        handlerOnError(response, path, context, apiCallBack, doAgain, responseType);
      }).catchError((error, stackTrace) {
        handlerCatchError(error, path, context, apiCallBack, doAgain);
      });
  }

  Future<CancelableOperation<dynamic>> createGetFile(
      BuildContext context, ResponseType responseType, String path, ApiCallBack apiCallBack, Function doAgain) async {
    Future<dynamic> apiService = ApiService.createNoBaseURL().getImage(path);
    var cancelable = CancelableOperation.fromFuture(
      apiService,
      onCancel: () => {},
    );
    return cancelable
      ..value.then((dynamic response) async {
        await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
      }, onError: (response) async {
        handlerOnError(response, path, context, apiCallBack, doAgain, responseType);
      }).catchError((error, stackTrace) {
        handlerCatchError(error, path, context, apiCallBack, doAgain);
      });
  }

  void showNoInternet(BuildContext context, ApiCallBack apiCallBack, Function doAgain) {
    Utilities().showTwoButtonDialog(
        context,
        DialogType.ERROR,
        null,
        AppLocalizations.of(context).titleNotification,
        AppLocalizations.of(context).noInternet,
        AppLocalizations.of(context).buttonClose,
        AppLocalizations.of(context).buttonTryAgain, () {
      if (apiCallBack != null) {
        var errors = Errors(-2, AppLocalizations.of(context).messageCommonError);
        apiCallBack?.onError(errors);
      }
    }, () {
      doAgain();
    });
  }

  List<Function> doAgainhandlerDoneApiLst = List();

  void callFunctionDoneApi() {
    for (var item in doAgainhandlerDoneApiLst) {
      item();
    }
    doAgainhandlerDoneApiLst.clear();
  }

  Future handlerDoneApi(response, BuildContext context, ApiCallBack apiCallBack, ResponseType responseType,
      Function doAgain, String path) async {
    catchSocketException(response);
    if (response is SocketException) {
      if (!listNoneInternet.contains(path)) {
        showNoInternet(context, apiCallBack, doAgain);
      } else {
        var errors = Errors(-2, AppLocalizations.of(context).messageCommonError);
        apiCallBack.onError(errors);
      }
    } else if (response is Response) {
      if (!handlerCompleteFuture(context, apiCallBack, response, responseType)) {
        await refreshToken(context, doAgain);
      }
    } else {
      handlerError(context, apiCallBack, response.toString());
    }
  }

  refreshToken(BuildContext context, Function doAgain) {}

  bool handlerCompleteFuture(BuildContext context, ApiCallBack apiCallBack, Response response, ResponseType type) {
    String statusCode = getStatusCodeRequestAPI(response, type);

    if (statusCode == Constants.STATUS_SUCCESS) {
      switch (type) {
        case ResponseType.FILE:
          {
            apiCallBack.onSuccessFile(response.bodyBytes, response.headers["content-type"]);
            break;
          }
        case ResponseType.OBJECT:
          {
            var baseResponse = BaseResponse.fromJson(response.body);
            apiCallBack.onSuccess(baseResponse);
            break;
          }
        case ResponseType.LIST:
          {
            var baseListResponse = BaseListResponse.fromJson(response.body);
            apiCallBack.onSuccessList(baseListResponse);
            break;
          }
      }
      return true;
    } else {
      switch (statusCode) {
        case Constants.B500:
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.B401:
          {
//            if (response.base.request.url.path.contains(Constants.PATH_REFRESH_TOKEN)) {
//              CancelableOperation cancelableLogout;
//              locator<Utilities>()
//                  .popupAndSignOut(context, cancelableLogout, AppLocalizations.of(context).expiredToken);
//              break;
//            } else if (response.base.request.url.path.contains(Constants.PATH_CONFIGURATION)) {
//              Errors errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
//              apiCallBack.onError(errors);
//              break;
//            }
//            return false;
            Errors errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.B400:
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.B403:
          {
            CancelableOperation cancelableLogout;
            locator<Utilities>().popupAndSignOut(context, cancelableLogout, AppLocalizations.of(context).noPermission);
            break;
          }
        default:
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
            apiCallBack.onError(errors);
            break;
          }
      }
      return true;
    }
  }

  String getStatusCodeRequestAPI(Response response, ResponseType type) {
    if (response.isSuccessful) {
      var baseResponse;
      switch (type) {
        case ResponseType.FILE:
          {
            return Constants.STATUS_SUCCESS;
          }
        case ResponseType.OBJECT:
          {
            baseResponse = BaseResponse.fromJson(response.body);
            break;
          }
        case ResponseType.LIST:
          {
            baseResponse = BaseListResponse.fromJson(response.body);
            break;
          }
      }
      if (baseResponse.success) {
        return Constants.STATUS_SUCCESS;
      }
      if (baseResponse.errors != null && baseResponse.errors.isNotEmpty) return baseResponse.errors[0];
      return Constants.B500;
    }
    return response.statusCode.toString();
  }

  handlerError(BuildContext context, ApiCallBack apiCallBack, String message) {
    Errors errors;
    try {
      errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
      apiCallBack.onError(errors);
    } catch (e) {
      locator<Utilities>().printLog(e.toString());
      try {
        errors = Errors(-1, AppLocalizations.of(context).messageCommonError);
        apiCallBack.onError(errors);
      } catch (e) {
        errors = Errors(-1001, AppLocalizations.of(context).messageCommonError);
        apiCallBack.onError(errors);
      }
    }
  }

  void catchSocketException(dynamic socketException) {
    if (socketException is SocketException) {
      locator<Utilities>().printLog(socketException.toString());
      var socket = socketException;
      locator<Utilities>().printLog(socket.message);
      locator<Utilities>().printLog(socket.port.toString());
      locator<Utilities>().printLog(socket.address.toString());
      locator<Utilities>().printLog(socket.osError.toString());
    }
    if (socketException is Response) {
      locator<Utilities>().printLog(socketException.toString());
      locator<Utilities>().printLog(socketException.bodyString);
      locator<Utilities>().printLog(socketException.body.toString());
    }
    locator<Utilities>().printLog(socketException.toString());
  }
}
