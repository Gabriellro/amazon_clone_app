import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/_export_models.dart';
import '../providers/_export_providers.dart';
import '_export_widgets.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context).items;
    final List<ProductModel> loadedProducts = provider;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[i],
          child: const ProductGridItem(),
        );
      },
    );
  }
}
