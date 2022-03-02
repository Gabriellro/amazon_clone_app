import 'package:amazon_clone_app/src/shared/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/_export_widgets.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false)
        .loadProducts()
        .then((value) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  "https://m.media-amazon.com/images/I/61KMBMeI9ZL._SX3000_.jpg",
                  height: 411,
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  width: double.infinity,
                  height: 408,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.1, 0.5, 0.9],
                      colors: [
                        Colors.transparent,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.7),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              child: Text(
                                "Continue comprando",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Image.network(
                              "https://m.media-amazon.com/images/I/61R-SLR8UeL._AC_SY355_.jpg",
                              width: 120,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Renove sua Casa",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Image.network(
                              "https://images-na.ssl-images-amazon.com/images/G/32/OHL/2022/RSC/Fevereiro/XCM_Manual_1407460_2174840_4469059_BR_379x304_1X_pt_BR._SY304_CB628418008_.jpg",
                              width: 136,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 56,
              child: Image.network(
                "https://corporate.discovery.com/wp-content/uploads/2016/06/16400-1024x384.jpg",
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Livros que você pode gostar",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const ProductGrid(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
