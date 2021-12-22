import 'dart:convert';
import 'package:http/http.dart' as http;

import 'entities/category.dart';
import 'entities/products.dart';

Future<List<CategoryModel>> fetchCategories() async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/ihsankcck/restorant-api/categories'));

  Iterable l = json.decode(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return List<CategoryModel>.from(
        l.map((model) => CategoryModel.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load categories');
  }
}

Future<List<ProductModel>> fetchProducts(categoryId) async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/ihsankcck/restorant-api/products/?category_id=$categoryId'));

  Iterable l = json.decode(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return List<ProductModel>.from(
        l.map((model) => ProductModel.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
