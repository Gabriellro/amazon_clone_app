import 'package:flutter/material.dart';

import 'order_tab_page.dart';

class AccountListsPage extends StatefulWidget {
  static String routeName = "AccountLists";
  const AccountListsPage({Key? key}) : super(key: key);

  @override
  State<AccountListsPage> createState() => _AccountListsPageState();
}

class _AccountListsPageState extends State<AccountListsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;
  static const List<Tab> _myTabs = <Tab>[
    Tab(text: 'Seus pedidos'),
    Tab(text: 'Compre novamente'),
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
                color: Colors.white,
                height: 54,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        isScrollable: true,
                        indicatorColor: Theme.of(context).primaryColor,
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
                    OrderTabPage(),
                    Center(
                      child: Text('Compre novamente'),
                    ),
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
