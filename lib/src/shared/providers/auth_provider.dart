import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/_export_exceptions.dart';
import '../utils/constants.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final _isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && _isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> singIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> singUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  void logout() {
    _token = null;
    _email = null;
    _uid = null;
    _expiryDate = null;
    notifyListeners();
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(
      Duration(seconds: timeToLogout ?? 0),
      logout,
    );
  }
}
