import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class ProductModel with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _tooggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> updateFavorite(String token, String uid) async {
    _tooggleFavorite();
    final res = await http.put(
      Uri.parse('${Constants.userFavoritesBaseUrl}/$uid/$id.json?auth=$token'),
      body: json.encode(isFavorite),
    );

    if (res.statusCode >= 400) {
      _tooggleFavorite();
    }
  }
}
