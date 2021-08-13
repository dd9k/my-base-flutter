// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<dynamic> postApi(
      String path, String authorization, Map<String, dynamic> body) {
    final $url = '$path';
    final $headers = {
      'Authorization': authorization,
      'Content-Type': 'application/json'
    };
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> postApiNoAuthenticate(
      String path, Map<String, dynamic> body) {
    final $url = '$path';
    final $headers = {'Content-Type': 'application/json'};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> getAPIWithoutToken(String path) {
    final $url = '$path';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send($request);
  }

  @override
  Future<dynamic> getAPIWithPath(String path, String authorization) {
    final $url = '$path';
    final $headers = {'Authorization': authorization};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> putAPI(
      String path, String authorization, Map<String, dynamic> body) {
    final $url = '$path';
    final $headers = {'Authorization': authorization};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> deleteAPI(String path, String authorization) {
    final $url = '$path';
    final $headers = {'Authorization': authorization};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> postApiUploadAvatar(
      String path, String authorization, MultipartFile image) {
    final $url = '$path';
    final $headers = {
      'Authorization': authorization,
      'Content-Type': 'multipart/form-data'
    };
    final $parts = <PartValue>[PartValueFile<MultipartFile>('image', image)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> putApi(
      String path, String authorization, Map<String, dynamic> body) {
    final $url = '$path';
    final $headers = {
      'Authorization': authorization,
      'Content-Type': 'application/json'
    };
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send($request);
  }

  @override
  Future<dynamic> getImage(String path) {
    final $url = '$path';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send($request);
  }
}
