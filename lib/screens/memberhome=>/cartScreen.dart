import 'package:flutter/material.dart';
import 'package:gym_el/provider/cart.dart';
import 'package:gym_el/provider/orders.dart';
import 'package:gym_el/widget/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [Color(0xff378ad6), Color(0xff2a288a)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Cart')),
        backgroundColor: Colors.transparent, // Set the background color of Scaffold to transparent
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 20)),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    TextButton(
                      onPressed: () => {
                        Provider.of<Orders>(context, listen: false)
                            .addItem(cart.items.values.toList(), cart.totalAmount),
                        cart.clear()
                      },
                      child: const Text('ORDER NOW'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => CartItemWidget(
                  id: cart.items.values.toList()[i].id,
                  productId: cart.items.keys.toList()[i],
                  title: cart.items.values.toList()[i].title,
                  quantity: cart.items.values.toList()[i].quantity,
                  price: cart.items.values.toList()[i].price,
                ),
                itemCount: cart.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
