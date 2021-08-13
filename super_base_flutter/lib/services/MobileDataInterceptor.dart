import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

/// Khoadd
/// 07/08/2021
///
class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw MobileException();
    }

    return request;
  }
}

class MobileException implements Exception {
  final message = "no_internet";

  @override
  String toString() => message;
}
