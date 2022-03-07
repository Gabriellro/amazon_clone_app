import 'package:amazon_clone_app/src/modules/is_auth_page.dart';
import 'package:flutter/material.dart';

import '../../modules/_export_modules.dart';

final Map<String, WidgetBuilder> routes = {
  IsAuthPage.routeName: (_) => const IsAuthPage(),
  AuthPage.routeName: (_) => const AuthPage(),
  BottomPage.routeName: (_) => const BottomPage(),
  HomePage.routeName: (_) => const HomePage(),
  ProductDatailPage.routeName: (_) => const ProductDatailPage(),
  CartPage.routeName: (_) => const CartPage(),
  AccountListsPage.routeName: (_) => const AccountListsPage(),
  ProductManagerPage.routeName: (_) => const ProductManagerPage(),
  ProductFormPage.routeName: (_) => const ProductFormPage(),
};
