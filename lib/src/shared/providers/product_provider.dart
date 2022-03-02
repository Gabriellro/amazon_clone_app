import 'dart:convert';
import 'dart:math';

import 'package:amazon_clone_app/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/_export_models.dart';
import '../utils/constants.dart';

class ProductProvider with ChangeNotifier {
  late final List<ProductModel> _items = [];

  List<ProductModel> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = ProductModel(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    return hasId ? updateProduct(product) : addProduct(product);
  }

  Future<void> loadProducts() async {
    _items.clear();
    final res = await http.get(Uri.parse('${Constants.productBaseUrl}.json'));
    if (res.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(res.body);
    data.forEach((key, value) {
      _items.add(
        ProductModel(
          id: key,
          name: value['name'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addProduct(ProductModel productModel) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json'),
      body: jsonEncode(
        {
          'name': productModel.name,
          'price': productModel.price,
          'description': productModel.description,
          'imageUrl': productModel.imageUrl,
          'isFavorite': productModel.isFavorite,
        },
      ),
    );

    final id = json.decode(response.body)['name'];

    _items.add(
      ProductModel(
        id: id,
        name: productModel.name,
        description: productModel.description,
        price: productModel.price,
        imageUrl: productModel.imageUrl,
        isFavorite: productModel.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel productModel) async {
    int i = _items.indexWhere((p) => p.id == productModel.id);

    if (i >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${productModel.id}.json'),
        body: json.encode(
          {
            'name': productModel.name,
            'price': productModel.price,
            'description': productModel.description,
            'imageUrl': productModel.imageUrl,
          },
        ),
      );

      _items[i] = productModel;
      notifyListeners();
    }
  }

  Future<void> favoriteProduct(ProductModel productModel) async {
    int i = _items.indexWhere((p) => p.id == productModel.id);

    if (i >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${productModel.id}.json'),
        body: json.encode(
          {
            'isFavorite': productModel.isFavorite,
          },
        ),
      );

      _items[i] = productModel;
      notifyListeners();
    }
  }

  Future<void> removeProduct(ProductModel productModel) async {
    int i = _items.indexWhere((p) => p.id == productModel.id);

    if (i >= 0) {
      final product = _items[i];
      _items.remove(product);
      notifyListeners();

      final res = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${productModel.id}.json'),
      );
      if (res.statusCode >= 400) {
        _items.insert(i, product);
        notifyListeners();
        throw HttpExceptions(
          msg: 'Não foi possivel excluir o produto!',
          statusCode: res.statusCode,
        );
      }
    }
  }
}
