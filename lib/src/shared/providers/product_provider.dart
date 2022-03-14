// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:math';

import 'package:amazon_clone_app/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/_export_models.dart';
import '../utils/constants.dart';

class ProductProvider with ChangeNotifier {
  final String _token;
  final String _uid;
  List<ProductModel> _items = [];

  ProductProvider([this._uid = '', this._token = '', this._items = const []]);

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

    final response = await http
        .get(Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'));

    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse('${Constants.userFavoritesBaseUrl}/$_uid.json?auth=$_token'),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        ProductModel(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addProduct(ProductModel productModel) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
      body: jsonEncode(
        {
          'name': productModel.name,
          'price': productModel.price,
          'description': productModel.description,
          'imageUrl': productModel.imageUrl,
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
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel productModel) async {
    int i = _items.indexWhere((p) => p.id == productModel.id);

    if (i >= 0) {
      await http.patch(
        Uri.parse(
            '${Constants.productBaseUrl}/${productModel.id}.json?auth=$_token'),
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

  Future<void> removeProduct(ProductModel productModel) async {
    int i = _items.indexWhere((p) => p.id == productModel.id);

    if (i >= 0) {
      final product = _items[i];
      _items.remove(product);
      notifyListeners();

      final res = await http.delete(
        Uri.parse(
            '${Constants.productBaseUrl}/${productModel.id}.json?auth=$_token'),
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
