import 'package:amazon_clone_app/src/shared/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final OrderModel orderModel;
  const OrderItem({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: SizedBox(
              width: 90,
              height: 90,
              child: Image.network(
                widget.orderModel.products.first.imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
            title: Text(widget.orderModel.products.first.name),
            subtitle: Text(
              ' Pedido de ${DateFormat('dd MMM yyyy').format(widget.orderModel.date)}',
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_right_rounded,
              ),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
          ),
          Visibility(
            visible: _isExpanded,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: SizedBox(
                width: double.infinity,
                height: (widget.orderModel.products.length * 40),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.orderModel.products.map(
                    (product) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                product.name,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              '${product.quantity}x R\$ ${product.price}',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
