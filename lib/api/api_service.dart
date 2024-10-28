import 'dart:developer';
import 'package:ecommerce/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>?> getAllProducts() async {
    try {
      log(" >> >> CONSULTOU API << << <<  ");

      var client = http.Client();
      var uri = Uri.parse('https://fakestoreapi.com/products');
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
