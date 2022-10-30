import 'package:flutter/material.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';
import './user_product_list_tile.dart';
import './products_manager.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }

  Widget buildUserProductListView(BuildContext context) {
    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (context, i) => Column(
            children: [
              UserProductListTitle(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: buildUserProductListView(context),
            );
          }),
    );
  }
}
