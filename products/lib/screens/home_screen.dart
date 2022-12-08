import 'package:flutter/material.dart';
import 'package:products/models/product.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/screens/loading_screen.dart';
import 'package:products/services/auth_service.dart';
import 'package:products/services/products_service.dart';
import 'package:products/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
              onPressed: () async {
                await authService.logout();
                // ignore: use_build_context_synchronously
                Navigator.popAndPushNamed(context, RoutesApp.login);
              },
              icon: const Icon(Icons.outlet_rounded))
        ],
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  productsService.selectedProduct =
                      productsService.products[index].copy();
                  Navigator.pushNamed(context, 'product');
                },
                child: ProductCard(
                  product: productsService.products[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
