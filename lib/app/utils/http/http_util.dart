import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpUtil {
  // get
  static Future<Map<String, dynamic>> get(
    String endPoint, {
    Map<String, String> headers,
  }) async {
    final client = http.Client();
    try {
      Uri _uri = Uri.parse(endPoint);
      final response = await client.get(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        final _data = jsonDecode(body) as Map<String, dynamic>;
        return _data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // post
  static Future<Map<String, dynamic>> post({
    String url,
    Map<String, String> headers,
  }) async {
    final client = http.Client();
    try {
      Uri _uri = Uri.parse(url);
      final response = await client.post(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        final _data = jsonDecode(body) as Map<String, dynamic>;
        return _data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // delete
  static Future<Map<String, dynamic>> deleteName({
    String url,
    Map<String, String> headers,
  }) async {
    final client = http.Client();
    try {
      Uri _uri = Uri.parse(url);
      final response = await client.delete(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        final _data = jsonDecode(body) as Map<String, dynamic>;
        return _data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // update
  static Future<Map<String, dynamic>> updateName({
    String url,
    Map<String, String> headers,
  }) async {
    final client = http.Client();
    try {
      Uri _uri = Uri.parse(url);
      final response = await client.put(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        final _data = jsonDecode(body) as Map<String, dynamic>;
        return _data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
