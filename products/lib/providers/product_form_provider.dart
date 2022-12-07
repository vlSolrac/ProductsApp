import 'package:flutter/cupertino.dart';
import 'package:products/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  Product product;

  ProductFormProvider(this.product);


  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
