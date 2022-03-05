import 'package:flutter/material.dart';

import '../../shared/widgets/_export_widgets.dart';

class AuthPage extends StatelessWidget {
  static String routeName = "/";

  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
              width: 200,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(height: size.height * 0.018),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.8,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: AuthForm(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
