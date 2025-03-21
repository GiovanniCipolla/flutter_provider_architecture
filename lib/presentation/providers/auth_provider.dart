// presentation/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_provider_architecture/core/token_manager.dart';
import 'package:flutter_provider_architecture/data/models/token.dart';
import 'package:flutter_provider_architecture/data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider(this._authRepository);

  Future<void> login(String email, String password) async {
    try {
      // _token = await _authRepository.login(email, password);
      if (email == 'admin' && password == 'admin') {
        TokenManager.setToken(
            Token(accessToken: 'token', refreshToken: 'token'));
        _isLoggedIn = true;
      }
      // attraverso il notifylistener avviseremo tutti gli ascoltatori
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      throw Exception('Errore durante il login: $e');
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    TokenManager.clearToken();
    notifyListeners();
  }
}
