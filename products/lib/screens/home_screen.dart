import 'package:flutter/material.dart';
import 'package:products/models/models.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/screens/loading/loading_screen.dart';
import 'package:products/services/product_service.dart';
import 'package:products/theme/theme_app.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
//Parametes.

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.

    final productService = Provider.of<ProductService>(context);

    return productService.isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Products"),
            ),
            body: ListView.builder(
              itemCount: productService.products.length,
              itemBuilder: (context, index) {
                final product = productService.products[index];

                return GestureDetector(
                  onTap: () {
                    productService.selectedProduct =
                        productService.products[index].copy();
                    Navigator.pushNamed(context, RoutesApp.product);
                  },
                  child: ProductCard(product: product),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, RoutesApp.product),
            ),
          );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: size.height * 0.50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(product.getUrl()),
                placeholder: const AssetImage("assets/jar-loading.gif"),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 50),
              width: double.infinity,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: ThemeApp.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * 0.3,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: ThemeApp.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    "\$ ${product.price}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          if (!product.avaliable)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: size.width * 0.3,
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      "Not Available",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
