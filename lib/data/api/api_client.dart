import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../model/exception/api_global_exception.dart';
import '../model/exception/api_no_internet_exception.dart';

enum HttpMethod { get, post, put, delete }

class HttpRequestExecutor {
  final HttpClient client;

  HttpRequestExecutor(this.client);

  Future<Map<String, dynamic>> executeRequest(
    HttpMethod method,
    Uri uri,
    Map<String, dynamic>? body,
  ) async {
    final HttpClientRequest request;

    try {
      switch (method) {
        case HttpMethod.get:
          request = await client.getUrl(uri);
          break;
        case HttpMethod.post:
          request = await client.postUrl(uri);
          break;
        case HttpMethod.put:
          request = await client.putUrl(uri);
          break;
        case HttpMethod.delete:
          request = await client.deleteUrl(uri);
          break;
      }
    } on SocketException catch (_) {
      throw ApiNoInternetException();
    }

    request.headers
      ..contentType = ContentType.json
      ..set(HttpHeaders.acceptHeader, 'application/json');
    if (kDebugMode) {
      print('HTTP here: --> ${request.method} ${request.uri.toString()} ${request.headers}');
    }

    if (body != null) {
      final json = jsonEncode(body);
      if (kDebugMode) {
        print('HTTP: --> $json');
      }
      request.write(json);
    }

    final response = await request.close();
    final json = await utf8.decodeStream(response);
    final map = jsonDecode(json) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return map;
    } else {
      final error = ApiGlobalException(message: response.statusCode.toString());
      if (kDebugMode) {
        print('HTTP: <-- $error)');
      }
      throw error;
    }
  }
}
