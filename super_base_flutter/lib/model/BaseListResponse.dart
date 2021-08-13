import 'package:json_annotation/json_annotation.dart';

part 'BaseListResponse.g.dart';

@JsonSerializable()
class BaseListResponse {
  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'data')
  List<Map<String, dynamic>> data;

  @JsonKey(name: 'messages')
  List<String> errors;

  BaseListResponse._();

  BaseListResponse(bool success, List<Map<String, dynamic>> data, List<String> errors) {
    this.success = success;
    this.data = data;
    this.errors = errors;
  }

  factory BaseListResponse.fromJson(Map<String, dynamic> json) => _$BaseListResponseFromJson(json);
}
