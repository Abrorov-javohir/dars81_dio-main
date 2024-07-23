import 'package:dars81_dio/core/network/dio_client.dart';
import 'package:dars81_dio/data/models/product.dart';
import 'package:dio/dio.dart';

class DioUsersService {
  final _dio = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get(path: "/v1/products");
      List<Product> products = [];

      for (var productData in response.data) {
        products.add(Product.fromJson(productData));
      }
      return products;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(String name, String description, double price) async {
    try {
      await _dio.post(
        path: "/v1/products",
        data: {
          'title': name,
          'description': description,
          'price': price,
        },
      );
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete(path: "/v1/products/$id");
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
