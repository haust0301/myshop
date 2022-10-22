import 'package:flutter/material.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';
import './user_product_list_tile.dart';
import './products_manager.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildAddButton() {
      return IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
          );
        },
      );
    }

    Widget buildUserProductListView() {
      return Consumer<ProductsManager>(
        builder: (ctx, productsManager, child) {
          return ListView.builder(
            itemCount: productsManager.itemCount,
            itemBuilder: (ctx, i) => Column(
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          buildAddButton(),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh products'),
        child: buildUserProductListView(),
      ),
    );
  }
}
