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
    if (res.body == "null") {
      isLoading = false;
      notifyListeners();
      return;
    }
    
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
      await createProduct(product);
    } else {
      final res = await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, "Product/${product.id}.json");
    final res = await http.put(url, body: product.toJson());

    final decodeData = jsonDecode(res.body);
    print(decodeData);

    final index = products.indexWhere((p) => p.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, "Product.json");

    final res = await http.post(url, body: product.toJson());

    final decodeData = json.decode(res.body);

    product.id = decodeData["name"];

    products.add(product);

    return product.id!;
  }

  Future<String> deleteProduct(Product product) async {
    final url = Uri.https(_baseUrl, "Product/${product.id}.json");

    final res = await http.delete(url);

    final decodeData = res.reasonPhrase;

    print(decodeData);

    // product.id = decodeData["name"];

    // products.add(product);
    notifyListeners();

    return decodeData!;
  }
}
