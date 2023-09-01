import 'package:flutter/material.dart';

import '../../shared/theme/theme.dart';
import 'buy_again_tab_page.dart';
import 'cart_tab_page.dart';

class CartPage extends StatefulWidget {
  static String routeName = "CartPage";

  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  bool select = false;
  late TabController _tabController;

  int _selectedIndex = 0;

  static const List<Tab> _myTabs = <Tab>[
    Tab(text: 'Carrinho'),
    Tab(text: 'Comprar novamente'),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _selectedIndex,
      length: _myTabs.length,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary,
                      AppColors.quaternary,
                    ],
                  ),
                ),
                height: 54,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        physics: const BouncingScrollPhysics(),
                        tabs: _myTabs,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    CartTabPage(),
                    BuyAgainTabPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
