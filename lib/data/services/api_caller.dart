import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';

class ApiCaller {
 static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await http.get(uri);
      int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);
      if (statusCode == 200) {
        return ApiResponse(
          responseCode: statusCode,
          isSuccess: true,
          responseData: decodedData,
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
      Response response = await http
          .post(uri, body: body != null ? jsonEncode(body) : null, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);
      if (statusCode == 200 || statusCode == 201) {
        return ApiResponse(
          responseCode: statusCode,
          isSuccess: true,
          responseData: decodedData,
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
