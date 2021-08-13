import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:super_base_flutter/utilities/Utilities.dart';

import 'ServiceLocator.dart';

/// Khoadd
/// 07/08/2021
///
class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton = new ConnectionStatusSingleton._internal();

  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = new StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection(isChangeState: false);
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      addNoConnection();
    } else {
      checkConnection(isChangeState: true);
    }
  }

  void addNoConnection() {
    bool previousConnection = hasConnection;
    hasConnection = false;
    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    locator<Utilities>().printLog("Connection: ${hasConnection.toString()}");
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection({@required bool isChangeState}) async {
    bool previousConnection = hasConnection;

    try {
      if (await DataConnectionChecker().hasConnection) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection && isChangeState) {
      connectionChangeController.add(hasConnection);
    }
    Utilities().printLog("Connection: ${hasConnection.toString()}");
    return hasConnection;
  }
}
