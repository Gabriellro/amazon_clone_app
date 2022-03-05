import 'dart:convert';

import 'package:amazon_clone_app/src/shared/exceptions/auth_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthProvider with ChangeNotifier {
  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url = '${Constants.authBaseUrl}$urlFragment?key=${Constants.apiKey}';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }

    print(body);
  }

  Future<void> singIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> singUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }
}
