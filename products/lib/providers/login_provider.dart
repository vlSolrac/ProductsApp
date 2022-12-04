import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool values) {
    _isLoading = values;
    notifyListeners();
  }

  bool isValidForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }
}
