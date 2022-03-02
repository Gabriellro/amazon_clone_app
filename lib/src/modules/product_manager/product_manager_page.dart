import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/providers/_export_providers.dart';
import '../../shared/widgets/_export_widgets.dart';
import '../_export_modules.dart';

class ProductManagerPage extends StatelessWidget {
  static String routeName = "/ProductManagerPage";
  const ProductManagerPage({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductProvider>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: productProvider.itemsCount,
          itemBuilder: (ctx, i) => ProductItem(
            productModel: productProvider.items[i],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          ProductFormPage.routeName,
        ),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
