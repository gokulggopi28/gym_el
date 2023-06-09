import 'package:flutter/material.dart';
import 'package:gym_el/screens/memberhome=%3E/orders_screen.dart';

import '../screens/memberhome=>/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('Hello Friends'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () => {Navigator.of(context).pushReplacementNamed('/')},
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () => {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName)
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Manage Products'),
          onTap: () => {
            Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          },
        )
      ]),
    );
  }
}
