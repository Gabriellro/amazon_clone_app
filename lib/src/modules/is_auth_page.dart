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
    return authProvider.isAuth ? const BottomPage() : const AuthPage();
  }
}
