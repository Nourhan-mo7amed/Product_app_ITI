import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:task5_iti/models/products_model.dart';

class ApiProvider {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getAllProducts() async {
    final Response response = await Dio().get(
      '$baseUrl/products',
      queryParameters: {
        "select": "id,title,description,category,price,thumbnail",
      },
    );

    if (response.statusCode == 200) {
      log('Response data: ${response.data.toString()}');

      // حوله إلى موديل Products
      final products = Products.fromJson(response.data);
      return products.products ?? [];
    } else {
      throw Exception('Failed to load products');
    }
  }
}
