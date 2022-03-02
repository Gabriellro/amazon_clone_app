import 'package:flutter/material.dart';

import '../../shared/widgets/_export_widgets.dart';

class OrderTabPage extends StatefulWidget {
  const OrderTabPage({Key? key}) : super(key: key);

  @override
  State<OrderTabPage> createState() => _OrderTabPageState();
}

class _OrderTabPageState extends State<OrderTabPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 0.5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            height: 54,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Theme.of(context).cardColor,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Pesquisar todos os pedidos",
                              border: InputBorder.none,
                              hintStyle: Theme.of(context).textTheme.subtitle1,
                            ),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list_rounded),
                  label: const Text("Filtro"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("ultimos 6 meses",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: const [
                SizedBox(
                  width: double.infinity,
                  height: 600,
                  child: OrderList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
