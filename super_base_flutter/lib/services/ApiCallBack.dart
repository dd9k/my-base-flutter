import 'dart:typed_data';

import 'package:super_base_flutter/model/BaseListResponse.dart';
import 'package:super_base_flutter/model/BaseResponse.dart';
import 'package:super_base_flutter/model/Errors.dart';

/// Khoadd
/// 07/08/2021
///
class ApiCallBack {
  Function _onSuccess;
  Function _onError;

  ApiCallBack(onSuccess, onError) {
    _onSuccess = onSuccess;
    _onError = onError;
  }

  void onSuccess(BaseResponse baseResponse) {
    _onSuccess(baseResponse);
  }

  void onSuccessFile(Uint8List file, String type) {
    _onSuccess(file, type);
  }

  void onError(Errors error) {
    _onError(error);
  }

  void onSuccessList(BaseListResponse baseListResponse) {
    _onSuccess(baseListResponse);
  }
}
