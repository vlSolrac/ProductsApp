import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:products/helpers/preferences.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = "identitytoolkit.googleapis.com";
  final String _firebaseToken = "AIzaSyCgxxPFZdS7EvAmsDLavSe4VZP45n1QX5M";
  bool hasToken = false;

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password
    };

    final url =
        Uri.https(_baseUrl, "/v1/accounts:signUp", {"key": _firebaseToken});

    final res = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodeData = jsonDecode(res.body);
    print(decodeData['localId']);

    if (decodeData.containsKey("idToken")) {
      return null;
    }

    return decodeData["error"]["message"];
  }

  Future<String?> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password
    };

    final url = Uri.https(
        _baseUrl, "/v1/accounts:signInWithPassword", {"key": _firebaseToken});

    final res = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodeData = jsonDecode(res.body);
    print(decodeData);

    if (decodeData.containsKey("idToken")) {
      Preferences.token = decodeData["idToken"];
      Preferences.idUser = decodeData["idToken"];
      return null;
    }

    return decodeData["error"]["message"];
  }

  Future logout() async {
    await Preferences.deletePreferences();
    notifyListeners();
  }

  Future<String?> getToken() async {
    final token = Preferences.token;

    if (token.isNotEmpty) {
      hasToken = true;
      return Preferences.token;
    }
    return "";
  }
}
