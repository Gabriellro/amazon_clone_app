import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/providers/_export_providers.dart';
import '../../shared/widgets/_export_widgets.dart';

class CartTabPage extends StatefulWidget {
  const CartTabPage({Key? key}) : super(key: key);

  @override
  State<CartTabPage> createState() => _CartTabPageState();
}

class _CartTabPageState extends State<CartTabPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              Text(
                "Enviar para Gabriel – Contagem 32340-030",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
        cart.itemsCount > 0
            ? Column(
                children: [
                  Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'SubTotal ',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' R\$ ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  cart.totalAmount
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
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Provider.of<OrderProvider>(
                                context,
                                listen: false,
                              ).addOrder(cart);

                              cart.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Fechar pedido ( ${cart.itemsCount} item)",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (ctx, i) => CartItem(
                              cartItemModel: items[i],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Seu carrinho da Amazon está vazio! :(',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Seu carrinho da Amazon está vazio! :(',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
