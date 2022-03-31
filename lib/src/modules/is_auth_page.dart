import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/providers/_export_providers.dart';
import '_export_modules.dart';

class IsAuthPage extends StatelessWidget {
  static String routeName = "/";
  const IsAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    //return authProvider.isAuth ? const BottomPage() : const AuthPage();
    return FutureBuilder(
      future: authProvider.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(child: Text('Ocorreu um erro!'));
        } else {
          return authProvider.isAuth ? const BottomPage() : const AuthPage();
        }
      },
    );
  }
}
