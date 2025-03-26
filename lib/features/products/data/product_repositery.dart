import 'dart:convert';

import 'package:http/http.dart' as http;

import 'product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts({required int page}) async {
    final limit = 20;
    final skip = (page - 1) * limit;
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> products = jsonData['products'];
        return products.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception("Failed to load products");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
