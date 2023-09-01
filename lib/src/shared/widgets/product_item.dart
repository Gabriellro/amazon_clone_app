import 'package:amazon_clone_app/src/modules/_export_modules.dart';
import 'package:amazon_clone_app/src/shared/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/_export_models.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  const ProductItem({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(productModel.imageUrl),
      ),
      title: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        child: Text(
          productModel.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      trailing: SizedBox(
        width: 100,
        height: 24,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductFormPage.routeName,
                    arguments: productModel,
                  );
                },
                icon: const Icon(Icons.edit_rounded)),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (cxt) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('sim'),
                      )
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      ).removeProduct(productModel);
                    } catch (e) {
                      msg.showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                });
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
            )
          ],
        ),
      ),
    );
  }
}
