import 'package:json_annotation/json_annotation.dart';
import 'package:super_base_flutter/database/Database.dart';

part 'ImageDownloaded.g.dart';

@JsonSerializable()
class ImageDownloaded {
  @JsonKey(name: 'linkDownload')
  String linkDownload;

  @JsonKey(name: 'localPath')
  String localPath;

  ImageDownloaded(this.linkDownload, this.localPath);

  ImageDownloaded.copyWithEntry(ImageDownloadedEntry entry) {
    this.linkDownload = entry.linkDownload;
    this.localPath = entry.localPath;
  }

  ImageDownloaded._();

  factory ImageDownloaded.fromJson(Map<String, dynamic> json) => _$ImageDownloadedFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDownloadedToJson(this);
}
