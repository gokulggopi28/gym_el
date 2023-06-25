import 'package:flutter/material.dart';
import 'package:gym_el/provider/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productid);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [Color(0xff378ad6), Color(0xff2a288a)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${product.price}',
                style: const TextStyle(color: Colors.green, fontSize: 40),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
