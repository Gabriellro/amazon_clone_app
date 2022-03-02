import 'dart:math';

import 'package:flutter/material.dart';

import '../models/_export_models.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items => {..._items};

  int get itemsCount => _items.length;

  void addItem(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      _items.update(
        productModel.id,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productModel.id,
        () => CartItemModel(
          id: Random().nextDouble().toString(),
          productId: productModel.id,
          name: productModel.name,
          quantity: 1,
          price: productModel.price,
          imageUrl: productModel.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItemModel) {
      total += cartItemModel.price * cartItemModel.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
          imageUrl: existingItem.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
