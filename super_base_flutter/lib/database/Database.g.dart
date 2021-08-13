// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ImageDownloadedEntry extends DataClass
    implements Insertable<ImageDownloadedEntry> {
  final String linkDownload;
  final String localPath;
  ImageDownloadedEntry({this.linkDownload, this.localPath});
  factory ImageDownloadedEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ImageDownloadedEntry(
      linkDownload: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}link_download']),
      localPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}local_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || linkDownload != null) {
      map['link_download'] = Variable<String>(linkDownload);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    return map;
  }

  ImageDownloadedEntityCompanion toCompanion(bool nullToAbsent) {
    return ImageDownloadedEntityCompanion(
      linkDownload: linkDownload == null && nullToAbsent
          ? const Value.absent()
          : Value(linkDownload),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
    );
  }

  factory ImageDownloadedEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ImageDownloadedEntry(
      linkDownload: serializer.fromJson<String>(json['linkDownload']),
      localPath: serializer.fromJson<String>(json['localPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'linkDownload': serializer.toJson<String>(linkDownload),
      'localPath': serializer.toJson<String>(localPath),
    };
  }

  ImageDownloadedEntry copyWith({String linkDownload, String localPath}) =>
      ImageDownloadedEntry(
        linkDownload: linkDownload ?? this.linkDownload,
        localPath: localPath ?? this.localPath,
      );
  @override
  String toString() {
    return (StringBuffer('ImageDownloadedEntry(')
          ..write('linkDownload: $linkDownload, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(linkDownload.hashCode, localPath.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ImageDownloadedEntry &&
          other.linkDownload == this.linkDownload &&
          other.localPath == this.localPath);
}

class ImageDownloadedEntityCompanion
    extends UpdateCompanion<ImageDownloadedEntry> {
  final Value<String> linkDownload;
  final Value<String> localPath;
  const ImageDownloadedEntityCompanion({
    this.linkDownload = const Value.absent(),
    this.localPath = const Value.absent(),
  });
  ImageDownloadedEntityCompanion.insert({
    this.linkDownload = const Value.absent(),
    this.localPath = const Value.absent(),
  });
  static Insertable<ImageDownloadedEntry> custom({
    Expression<String> linkDownload,
    Expression<String> localPath,
  }) {
    return RawValuesInsertable({
      if (linkDownload != null) 'link_download': linkDownload,
      if (localPath != null) 'local_path': localPath,
    });
  }

  ImageDownloadedEntityCompanion copyWith(
      {Value<String> linkDownload, Value<String> localPath}) {
    return ImageDownloadedEntityCompanion(
      linkDownload: linkDownload ?? this.linkDownload,
      localPath: localPath ?? this.localPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (linkDownload.present) {
      map['link_download'] = Variable<String>(linkDownload.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageDownloadedEntityCompanion(')
          ..write('linkDownload: $linkDownload, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }
}

class $ImageDownloadedEntityTable extends ImageDownloadedEntity
    with TableInfo<$ImageDownloadedEntityTable, ImageDownloadedEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ImageDownloadedEntityTable(this._db, [this._alias]);
  final VerificationMeta _linkDownloadMeta =
      const VerificationMeta('linkDownload');
  GeneratedTextColumn _linkDownload;
  @override
  GeneratedTextColumn get linkDownload =>
      _linkDownload ??= _constructLinkDownload();
  GeneratedTextColumn _constructLinkDownload() {
    return GeneratedTextColumn(
      'link_download',
      $tableName,
      true,
    );
  }

  final VerificationMeta _localPathMeta = const VerificationMeta('localPath');
  GeneratedTextColumn _localPath;
  @override
  GeneratedTextColumn get localPath => _localPath ??= _constructLocalPath();
  GeneratedTextColumn _constructLocalPath() {
    return GeneratedTextColumn(
      'local_path',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [linkDownload, localPath];
  @override
  $ImageDownloadedEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cip_image_downloaded';
  @override
  final String actualTableName = 'cip_image_downloaded';
  @override
  VerificationContext validateIntegrity(
      Insertable<ImageDownloadedEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('link_download')) {
      context.handle(
          _linkDownloadMeta,
          linkDownload.isAcceptableOrUnknown(
              data['link_download'], _linkDownloadMeta));
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path'], _localPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {linkDownload};
  @override
  ImageDownloadedEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ImageDownloadedEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ImageDownloadedEntityTable createAlias(String alias) {
    return $ImageDownloadedEntityTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ImageDownloadedEntityTable _imageDownloadedEntity;
  $ImageDownloadedEntityTable get imageDownloadedEntity =>
      _imageDownloadedEntity ??= $ImageDownloadedEntityTable(this);
  ImageDownloadedDAO _imageDownloadedDAO;
  ImageDownloadedDAO get imageDownloadedDAO =>
      _imageDownloadedDAO ??= ImageDownloadedDAO(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [imageDownloadedEntity];
}
