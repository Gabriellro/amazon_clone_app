import 'package:amazon_clone_app/src/shared/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '_export_widgets.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrderProvider>(context, listen: false).loadOrders(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return Consumer<OrderProvider>(
            builder: (context, orders, child) => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.itemsCount,
              itemBuilder: (ctx, i) => OrderItem(
                orderModel: orders.items[i],
              ),
            ),
          );
        }
      },
    );
  }
}
