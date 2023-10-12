import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app/common/constants/apiendpoints.dart';



class ApiService {
  static const String noInternet = "No internet connection.";
  static const String requestFailed = "Request failed with status";
  static const String serverConnectivityFailed = "Failed to connect to the server.";
  static const Map<String, dynamic> queryParam= {'api_key':'a7ed5c786538fcad8df57a03ec07aa2f'};




  static final dio = Dio()
    ..options.headers = {'Content-Type': 'application/json',}
    ..options.baseUrl =ApiEndPoint.baseUrl
    ..options.validateStatus = ((status) => status! < 500)
    ..options.connectTimeout = Duration(milliseconds: 5000)
    ..options.receiveTimeout = Duration(milliseconds: 3000);

  static Future<Response> get(String path,
      {Map<String, dynamic>? params=queryParam}) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('$requestFailed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(serverConnectivityFailed);
    }
  }

  static Future<Response> post(String path, {required dynamic data}) async {
    try {
      final response = await dio.post(
        path,
        data: json.encode(data),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('$requestFailed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(serverConnectivityFailed);
    }
  }





  static String? _encodeData(Map<String, dynamic> data) {
    // if (data == null) return null;
    final json = jsonEncode(data);
    return base64.encode(utf8.encode(json));
  }

  static dynamic _decodeData(String data) {
    // if (data == null) return null;
    final decodedData = utf8.decode(base64.decode(data));
    return jsonDecode(decodedData);
  }
}