import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'http://mohamedtahoon.runasp.net/api'; // Replace with your API URL

  Future<Response> signIn(String email, String password,int id,String name,String image) async {
    try {
      print(email);
      print(password);
      final response = await _dio.post(
        '$_baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
          'id' : id,
          'name' : name,
          'image': image,

        },
      );
      return response;
    } on DioException catch (e) {
      // Handle specific Dio errors
      throw _createError(e.response, _getErrorMessage(e));
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('Unexpected error during sign-in: $e');
    }
  }

  Future<Response> signUp(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/users',
        data: {
          'email': email,
          'password': password,

        },
      );
      return response;
    } on DioException catch (e) {
      // Handle specific Dio errors
      throw _createError(e.response, _getErrorMessage(e));
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('Unexpected error during sign-up: $e');
    }
  }

  // Custom error creation function
  Exception _createError(Response? response, String message) {
    final host = _dio.options.baseUrl; // Extract host from Dio options
    if (message.contains('Failed host lookup')) {
      return Exception("Failed host lookup: '$host'");
    }
    return Exception(
        '$message (Status code: ${response?.statusCode ?? 'unknown'})');
  }

  // Helper function to interpret Dio errors
  String _getErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return "Failed host lookup: '${e.requestOptions.uri.host}'";
    } else if (e.type == DioExceptionType.badResponse) {
      return e.response?.data['message'] ?? 'Bad response from server';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else {
      return e.message ?? 'Unknown error occurred';
    }
  }
}
