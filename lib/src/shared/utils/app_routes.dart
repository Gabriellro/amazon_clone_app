import 'package:flutter/material.dart';

import '../../modules/_export_modules.dart';

final Map<String, WidgetBuilder> routes = {
  AuthPage.routeName: (_) => const AuthPage(),
  BottomPage.routeName: (_) => const BottomPage(),
  HomePage.routeName: (_) => const HomePage(),
  ProductDatailPage.routeName: (_) => const ProductDatailPage(),
  CartPage.routeName: (_) => const CartPage(),
  AccountListsPage.routeName: (_) => const AccountListsPage(),
  ProductManagerPage.routeName: (_) => const ProductManagerPage(),
  ProductFormPage.routeName: (_) => const ProductFormPage(),
};
