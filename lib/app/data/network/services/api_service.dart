import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:getx_project/constants/app_constants.dart';

class ApiService {
  static ApiService? _instance;
  late final Client _client;
  late final Account _account;
  late final Databases _database;

  ApiService.internal() {
    _client = Client()
      ..setEndpoint(AppConstans.appwriteEndpoint)
      ..setProject(AppConstans.appwriteProjectId);
    _account = Account(_client);
    _database = Databases(_client);
  }
  static ApiService? get instance {
    _instance ??= ApiService.internal();
    return _instance!;
  }

  Future login({required String email, required String password}) {
    return _account.createEmailSession(email: email, password: password);
  }

  Future signup(
      {required String email, required String password, String? name}) {
    return _account.create(
      userId: "unique()",
      email: email,
      password: password,
      name: name,
    );
  }

  Future logout() {
    return _account.deleteSession(sessionId: "current");
  }

  Future oAuthLogin(String provider) {
    return _account.createOAuth2Session(provider: provider);
  }
}
