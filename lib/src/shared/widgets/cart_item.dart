import 'package:amazon_clone_app/src/shared/models/_export_models.dart';
import 'package:amazon_clone_app/src/shared/providers/_export_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItemModel;
  const CartItem({Key? key, required this.cartItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemModel.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Excluir",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
      onDismissed: (_) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(cartItemModel.productId);
      },
      confirmDismiss: (_) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Tem certeza?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('sim'),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.network(cartItemModel.imageUrl),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 24 - 98,
                      child: Text(
                        cartItemModel.name,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "por autor",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "capa commun",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "R\$",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          (cartItemModel.price * cartItemModel.quantity)
                              .toStringAsFixed(2)
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Em estoque",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .removeSingleItem(cartItemModel.productId);
                  },
                  icon: const Icon(
                    Icons.remove_rounded,
                  ),
                ),
                Text(cartItemModel.quantity.toString()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
