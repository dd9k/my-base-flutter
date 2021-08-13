import 'package:moor/moor.dart';

import 'daos/ImageDownloadedDAO.dart';
import 'entities/ImageDownloadedEntity.dart';

part 'Database.g.dart';

@UseMoor(tables: [
  ImageDownloadedEntity
], daos: [
  ImageDownloadedDAO
])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) {
      return m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {

      }
    });
  }

  Future<void> deleteAllDataInDB() async {
    imageDownloadedDAO.deleteAll();
  }
}
