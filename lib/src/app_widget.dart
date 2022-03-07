import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/providers/_export_providers.dart';
import 'shared/theme/theme.dart';
import 'shared/utils/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (_) => ProductProvider('', []),
          update: (ctx, authProvider, previous) {
            return ProductProvider(
              authProvider.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (_) => OrderProvider('', []),
          update: (context, authProvider, previous) {
            return OrderProvider(
              authProvider.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
