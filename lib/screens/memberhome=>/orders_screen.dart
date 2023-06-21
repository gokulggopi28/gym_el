import 'package:flutter/material.dart';
import 'package:gym_el/provider/orders.dart';
import 'package:gym_el/widget/drawer.dart';
import 'package:gym_el/widget/order_item.dart';
import 'package:provider/provider.dart';



class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderContainer = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItemWidget(
          order: orderContainer.items[i],
        ),
        itemCount: orderContainer.items.length,
      ),
    );
  }
}
