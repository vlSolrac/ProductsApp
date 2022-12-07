import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/models/models.dart';
import 'package:products/providers/product_form_provider.dart';
import 'package:products/screens/login/login_screen.dart';
import 'package:products/services/product_service.dart';
import 'package:products/theme/theme_app.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
//Parametes.

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.
    // final data = ModalRoute.of(context)?.settings.arguments;
    // if (data != null) data as Product;

    final size = MediaQuery.of(context).size;
    final statusBar = MediaQuery.of(context).viewPadding;

    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (context) => ProductFormProvider(productService.selectedProduct),
      child: ProductScreenBody(
        size: size,
        productService: productService,
        statusBar: statusBar,
      ),
    );
  }
}

class ProductScreenBody extends StatelessWidget {
  const ProductScreenBody({
    Key? key,
    required this.size,
    required this.productService,
    required this.statusBar,
  }) : super(key: key);

  final Size size;
  final ProductService productService;
  final EdgeInsets statusBar;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (!formProvider.isValidForm()) return;

          await productService.saveOrCreateProduct(formProvider.product);
        },
        child: const Icon(Icons.save_rounded),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Opacity(
                      opacity: 0.7,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            productService.selectedProduct.getUrl(),
                          ),
                          placeholder: const AssetImage("assets/no-image.png"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: statusBar.top,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                            splashRadius: 1,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            splashRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const ProductForm(),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}

class ProductForm extends StatelessWidget {
  const ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);

    final product = formProvider.product;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formProvider.formKey,
          child: Column(
            children: [
              CustomInput(
                initialValue: product.name,
                label: "Name",
                hint: "Product name",
                icon: Icons.android,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "El nombre el obligatorio";
                },
              ),
              const SizedBox(height: 10),
              CustomInput(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                initialValue: product.price.toString(),
                label: "Price",
                hint: "\$100.00",
                icon: Icons.monetization_on_outlined,
                onChanged: (value) => product.price = double.parse(value),
              ),
              SwitchCustom(active: product.avaliable, product: product),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchCustom extends StatefulWidget {
  final bool active;
  final Product product;
  const SwitchCustom({
    super.key,
    required this.active,
    required this.product,
  });
  @override
  State<SwitchCustom> createState() => _SwitchCustomState();
}

class _SwitchCustomState extends State<SwitchCustom> {
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    isAvailable = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: isAvailable,
      onChanged: (value) {
        isAvailable = value;
        widget.product.avaliable = value;
        setState(() {});
      },
      title: const Text("Available?"),
      activeColor: ThemeApp.primary,
    );
  }
}
