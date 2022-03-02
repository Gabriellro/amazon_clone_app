import 'package:amazon_clone_app/src/shared/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modules/_export_modules.dart';
import '../theme/theme.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ProductDatailPage.routeName,
        arguments: product,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        alignment: Alignment.center,
        height: 340,
        color: AppColors.softwhite,
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              height: 148,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'R\$ ${product.price.toString()}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
