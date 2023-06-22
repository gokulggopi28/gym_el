import 'package:flutter/material.dart';
import 'package:gym_el/provider/cart.dart';
import 'package:gym_el/provider/products.dart';
import 'package:gym_el/screens/memberhome=%3E/cartScreen.dart';
import 'package:gym_el/widget/badge.dart';
import 'package:gym_el/widget/drawer.dart';
import 'package:gym_el/widget/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOption { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavouritesOnly = false;
  var _init = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) => {
        setState(() {
          _isLoading = false;
        })
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliments'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption value) => {
              setState(
                    () => {
                  if (value == FilterOption.favorite)
                    {_showFavouritesOnly = true}
                  else
                    {_showFavouritesOnly = false}
                },
              )
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOption.favorite,
                child: Text('Only Favourites'),
              ),
              const PopupMenuItem(
                value: FilterOption.all,
                child: Text('All'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => CustomBadge(
              value: cartData.itemCount.toString(),
              child: ch as Widget,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => {
                Navigator.of(context).pushNamed(CartScreen.routeName),
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
    body: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 1.0],
    colors: [Color(0xff378ad6), Color(0xff2a288a)],
    ),
    ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(isFav: _showFavouritesOnly),
    ),
    );
  }
}
