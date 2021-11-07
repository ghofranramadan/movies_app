import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:movies_app/api/api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider {
  static late Dio dio;

  static int() {
    dio = Dio(BaseOptions(
      baseUrl: API.baseUrl,
      receiveDataWhenStatusError: true,
    ));

    if (kDebugMode) dio.interceptors.add(logger);
  }

  static PrettyDioLogger logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    error: true,
  );
  static bool validResponse(var statusCode) =>
      statusCode >= 200 && statusCode < 300;

  static final Map<String, dynamic> _apiHeaders = <String, dynamic>{
    'Content-Type': 'application/json',
  };

  static Future<Response> getApiData({
    required String url,
    var noOfPage,
  }) async {
    return await dio.get(
      url,
      queryParameters: {'api_key': API.apiKey, 'page': noOfPage},
      options: Options(
        headers: {
          ..._apiHeaders,
        },
      ),
    );
  }
}
