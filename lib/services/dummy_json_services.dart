import 'package:assignment_1/models/dummy_json_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// PARSE IN BACKGROUND
DummyJsonModels parseDummyJson(String responseBody) {
  return dummyJsonModelsFromJson(responseBody);
}

class DummyJsonServices {
  Future<List<Product>?> readProductApi() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final data = await compute(parseDummyJson, response.body);

        return data.products;
      } else {
        throw Exception("Error Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception: ${e.toString()}");
    }
  }
}
