import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:logger/logger.dart';
import 'package:task_management/UI/controller/auth_controller.dart';
import 'package:task_management/app.dart';

class ApiCaller {
  static final Logger _logger = Logger();
  static String? accessToken;
  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      //debugging
      _logRequest(url);
      Response response = await http.get(uri, headers: {
        'token': accessToken ?? "",
      });
      //debugging
      _logResponse(url, response);
      int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);
      if (statusCode == 200) {
        return ApiResponse(
          responseCode: statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          responseCode: -1,
          isSuccess: false,
          responseData: null,
        );
      } else {
        return ApiResponse(
          responseCode: statusCode,
          isSuccess: false,
          responseData: decodedData,
        );
      }
    } catch (e) {
      return ApiResponse(
          responseCode: -1,
          responseData: null,
          isSuccess: false,
          errorMessage: e.toString());
    }
  }

  static Future<ApiResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);

      //debugging
      _logRequest(url, body: body);

      Response response = await http
          .post(uri, body: body != null ? jsonEncode(body) : null, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "token": accessToken ?? "",
      });

      //debugging
      _logResponse(url, response);
      int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);
      if (statusCode == 200 || statusCode == 201) {
        return ApiResponse(
          responseCode: statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          responseCode: -1,
          isSuccess: false,
          responseData: null,
        );
      } else {
        return ApiResponse(
          responseCode: statusCode,
          isSuccess: false,
          responseData: decodedData,
        );
      }
    } catch (e) {
      return ApiResponse(
          responseCode: -1,
          responseData: null,
          isSuccess: false,
          errorMessage: e.toString());
    }
  }

// debugging
  static _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'Request URL=>$url\n'
      'Request Body=>$body\n',
    );
  }

  static _logResponse(String url, Response response) {
    _logger.i(
      'Response URL=>$url\n'
      'Status Code=>${response.statusCode}\n'
      'Response Body=>${response.body}\n',
    );
  }

  static Future<void> _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        '/login',
        (route) => false);
  }
}

class ApiResponse {
  final int responseCode;
  final dynamic responseData;
  final bool isSuccess;
  final String? errorMessage;
  ApiResponse(
      {required this.responseCode,
      required this.responseData,
      required this.isSuccess,
      this.errorMessage = 'Something went wrong'});
}
