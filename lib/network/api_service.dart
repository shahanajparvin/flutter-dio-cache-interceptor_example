import 'package:dio/dio.dart';
import 'package:flutter_dio_example/models/post.dart';
import 'package:flutter_dio_example/network/dio_exception.dart';
import 'package:flutter_dio_example/network/endpoints.dart';

class ApiService {

  static Future<T> handleApiCall<T>(Future<T> apiCall) async {
    try {
      final response = await apiCall;
      return response;
    } on DioError catch (err) {
      throw DioException.fromDioError(err);
    } catch (e) {
      rethrow;
    }
  }
}