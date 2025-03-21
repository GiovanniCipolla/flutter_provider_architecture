// presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_provider_architecture/data/models/user.dart';
import 'package:flutter_provider_architecture/data/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository;
  User? _user;

  UserProvider(this._userRepository);

  User? get user => _user;

  Future<void> fetchUser() async {
    try {
      _user = await _userRepository.getUser();
      notifyListeners();
    } catch (e) {
      // Gestisci l'errore
    }
  }
}
