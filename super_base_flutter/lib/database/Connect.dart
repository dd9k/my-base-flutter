import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path/path.dart' as p;
import 'package:super_base_flutter/utilities/Utilities.dart';

import 'Database.dart';

// For mobile
Database constructDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      var path = await Utilities().localPath("DB");
      final dbFile = File(p.join(path, 'super_base_flutter.sqlite'));
      return VmDatabase(dbFile, logStatements: logStatements);
    });
    return Database(executor);
  }
  return Database(VmDatabase.memory(logStatements: logStatements));
}
