import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/snack_bar.dart';
import 'apis.dart';

class ApiCall {
  static final ApiCall _instance = ApiCall._internal();

  factory() {
    return _instance;
  }

  ApiCall._internal();

  static final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: Apis.baseUrl,
    ),
  );
static getApiCall({
  required String? endPoint,
}) async {
  try {
    if (endPoint == null) {
      log("Endpoint cannot be null");
      return null; 
    }

    dio.Response response;

    response = await _dio.get(endPoint);
    log("FINAL URL: ${response.requestOptions.uri}");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return response.data;
    }
  } on dio.DioException catch (e) {

    _handleDioError(e);
  }
}


static String _handleDioError(dio.DioException error) {
  log('error message exception: ${error.response?.data}');
  
  if (error.response != null && error.response!.data != null) {
    // Handle "Please Update Your App" error
    showSnakBar(1, msg: error.response!.data['msg']);
  }

  switch (error.type) {
    case dio.DioExceptionType.connectionTimeout:
      return "Connection timeout. Please try again.";
    case dio.DioExceptionType.sendTimeout:
      return "Request send timeout. Please try again.";
    case dio.DioExceptionType.receiveTimeout:
      return "Response timeout. Please try again.";
    case dio.DioExceptionType.badResponse:
      return "Received invalid status code: ${error.response?.data['msg']}";
    case dio.DioExceptionType.cancel:
      return "Request to the server was cancelled.";
    case dio.DioExceptionType.connectionError:
      return "No Internet connection.";
    default:
      return "Something went wrong. Please try again.";
  }
}

}
