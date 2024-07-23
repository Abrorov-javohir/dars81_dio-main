import 'package:dio/dio.dart';
import 'package:dars81_dio/data/models/product.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient._singleton() {
    _dio
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..options.baseUrl = "https://api.escuelajs.co/api"
      ..interceptors.add(TestInterceptor());
  }

  static final _singletonConstructor = DioClient._singleton();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParams,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({
    required String path,
  }) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }
}

class TestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request [${options.method}] => PATH: ${options.path}');
    print('Request Data: ${options.data}');
    print('Request Headers: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response [${response.statusCode}] => DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Error [${err.response?.statusCode}] => MESSAGE: ${err.message}');
    if (err.response != null) {
      print('Error Data: ${err.response?.data}');
      print('Error Headers: ${err.response?.headers}');
    }
    super.onError(err, handler);
  }
}
