// data/repositories/user_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_provider_architecture/core/api_client.dart';
import 'package:flutter_provider_architecture/core/costants.dart';
import 'package:flutter_provider_architecture/data/models/user.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<User> getUser() async {
    try {
      final response = await _apiClient.dio.get(Constants.userEndpoint);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          'Errore durante il recupero dei dati utente: ${e.message}');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await _apiClient.dio.put(
        Constants.userEndpoint,
        data: user.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          'Errore durante l\'aggiornamento dei dati utente: ${e.message}');
    }
  }
}
