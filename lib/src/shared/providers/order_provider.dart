import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/_export_models.dart';
import '../utils/constants.dart';
import '_export_providers.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _items = [];

  List<OrderModel> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    _items.clear();

    final res = await http.get(Uri.parse('${Constants.orderBaseUrl}.json'));

    if (res.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(res.body);
    data.forEach((key, value) {
      _items.add(OrderModel(
        id: key,
        date: DateTime.parse(value['date']),
        total: value['total'],
        products: (value['products'] as List<dynamic>).map((item) {
          return CartItemModel(
            id: item['id'],
            productId: item['productId'],
            name: item['name'],
            quantity: item['quantity'],
            price: item['price'],
            imageUrl: item['imageUrl'],
          );
        }).toList(),
      ));
    });
    notifyListeners();
  }

  Future<void> addOrder(CartProvider cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map((cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                  'imageUrl': cartItem.imageUrl,
                })
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      OrderModel(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }
}
