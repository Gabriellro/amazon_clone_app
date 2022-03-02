import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/models/_export_models.dart';
import '../../shared/providers/cart_provider.dart';
import '../../shared/theme/theme.dart';

class ProductDatailPage extends StatefulWidget {
  static String routeName = "/ProductDatail";

  const ProductDatailPage({Key? key}) : super(key: key);

  @override
  State<ProductDatailPage> createState() => _ProductDatailPageState();
}

class _ProductDatailPageState extends State<ProductDatailPage> {
  @override
  Widget build(BuildContext context) {
    final productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
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
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black,
                  ),
                ),
                Expanded(
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
                          hintText: productModel.name,
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
              ],
            ),
          ),
        ),
      ),
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
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              width: double.infinity,
              color: AppColors.softwhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tatsuki Fujimoto",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    productModel.name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Edição Português",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[700],
                      ),
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[700],
                      ),
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[700],
                      ),
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[700],
                      ),
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber[700],
                      ),
                      Text(
                        "(1.563)",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Image.network(
                              productModel.imageUrl,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              productModel.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                            ),
                            onPressed: () => productModel.updateFavorite(),
                            color: Theme.of(context).primaryColor,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.share_rounded),
                              onPressed: () {},
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${productModel.price.toStringAsFixed(2).toString()}',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        "Enviar para Gabriel – Contagem 32340-030",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.maybeOf(context)
                              ?.hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${productModel.name} foi adionado ao carrinho!'),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'Desfazer',
                                onPressed: () => cart.removeSingleItem(
                                  productModel.id,
                                ),
                              ),
                            ),
                          );
                          cart.addItem(productModel);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Adiconar ao carrinho",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.amber[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Comprar agora",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
