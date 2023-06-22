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
      body:Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [Color(0xff378ad6), Color(0xff2a288a)],
    ),
    ),
    child:
    ListView.builder(

        itemBuilder: (ctx, i) => OrderItemWidget(
          order: orderContainer.items[i],
        ),
        itemCount: orderContainer.items.length,
      ),
    )
    );
  }
}
