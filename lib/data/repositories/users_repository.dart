import 'package:dars81_dio/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:dars81_dio/data/models/product.dart';

class UsersRepository {
  final DioClient _dioClient = DioClient();

  Future<void> addUser(String name, String description, double price,
      String categoryId, String imageUrl) async {
    final payload = {
      'title': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'images': [imageUrl],
    };
    try {
      Response response = await _dioClient.post(
        path: '/v1/products/',
        data: payload,
      );
      print('Add User Response: ${response.data}');
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<void> updateProductImage(int productId, String newImageUrl) async {
    final payload = {
      'images': [newImageUrl],
    };
    try {
      Response response = await _dioClient.put(
        path: '/v1/products/$productId',
        data: payload,
      );
      print('Update Image Response: ${response.data}');
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<List<Product>> getUsers() async {
    try {
      Response response = await _dioClient.get(path: '/v1/products/');
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      Response response = await _dioClient.delete(path: '/v1/products/$id');
      print('Delete Product Response: ${response.data}');
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<void> updateProduct(int id, String name, String description,
      double price, String image, String category) async {
    final payload = {
      'title': name,
      'description': description,
      'price': price,
      'categoryId': category,
      'images': [image],
    };
    try {
      Response response = await _dioClient.put(
        path: '/v1/products/$id',
        data: payload,
      );
      print('Update Product Response: ${response.data}');
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      print('Dio Error Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      print('Headers: ${e.response?.headers}');
    } else {
      print('Dio Error Message: ${e.message}');
      print('Request Options: ${e.requestOptions}');
    }
  }
}
