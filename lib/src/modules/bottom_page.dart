// ignore_for_file: unused_field

import 'package:amazon_clone_app/src/modules/_export_modules.dart';
import 'package:flutter/material.dart';

import '../shared/theme/app_colors.dart';

class BottomPage extends StatefulWidget {
  static String routeName = "/BottomPage";
  const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage>
    with SingleTickerProviderStateMixin {
  int _selectindex = 0;

  late TabController _tabController;

  static const List<Tab> _myTabs = <Tab>[
    Tab(icon: Icon(Icons.home_rounded)),
    Tab(icon: Icon(Icons.person_rounded)),
    Tab(icon: Icon(Icons.shopping_cart_rounded)),
    Tab(icon: Icon(Icons.menu_rounded)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectindex = _tabController.index;
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
    return Scaffold(
      body: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                  AppColors.quaternary,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      hintText: "Pesquisar na Amazon.com.br",
                      border: InputBorder.none,
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                      suffixIcon: const Icon(
                        Icons.center_focus_weak_rounded,
                        color: Colors.black26,
                      ),
                    ),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            AccountListsPage(),
            CartPage(),
            ProductManagerPage(),
          ],
        ),
      ),
      bottomNavigationBar: DefaultTabController(
        length: _myTabs.length,
        child: Container(
          height: 56,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Theme.of(context).cardColor,
          ),
          child: TabBar(
            tabs: _myTabs,
            isScrollable: true,
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            labelColor: Theme.of(context).primaryColor,
            labelPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 12),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 5,
                color: Theme.of(context).primaryColor,
              ),
              insets: const EdgeInsets.only(
                bottom: 50,
              ),
            ),
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
      ),
    );
  }
}
