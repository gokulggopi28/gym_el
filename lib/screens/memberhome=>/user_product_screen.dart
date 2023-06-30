import 'package:flutter/material.dart';
import 'package:gym_el/provider/products.dart';
import 'package:gym_el/widget/drawer.dart';
import 'package:gym_el/widget/user_product_item.dart';
import 'package:provider/provider.dart';
import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    Provider.of<Products>(context).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: true,
      ),
      // drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  UserProductItemWidget(
                    id: productsContainer.items[i].id,
                    imageUrl: productsContainer.items[i].imageUrl,
                    title: productsContainer.items[i].title,
                  ),
                  const Divider()
                ],
              );
            },
            itemCount: productsContainer.items.length,
          ),
        ),
      ),
    );
  }
}
