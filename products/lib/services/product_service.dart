import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:products/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = "productsapp-57a00-default-rtdb.firebaseio.com";

  final List<Product> products = [];

  bool isLoading = false;
  bool isSaving = false;
  late Product selectedProduct;

  ProductService() {
    getAllProducts();
  }

  Future getAllProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, "Product.json");

    final res = await http.get(url);
    final Map<String, dynamic> productMap = json.decode(res.body);

    productMap.forEach((key, value) {
      final temp = Product.fromMap(value);

      temp.id = key;

      products.add(temp);
    });

    isLoading = false;
    notifyListeners();
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
    } else {
      final res = await createProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, "Product/${product.id}.json");
    final res = await http.put(url, body: product.toJson());
    final decodeData = res.body;

    print(decodeData);

    return product.id!;
  }
}
