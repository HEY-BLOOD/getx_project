import 'package:dio/dio.dart';

import '../client/dio_client.dart';
import '../end_points.dart';

class UserService {
  final DioClient dioClient;

  UserService({required this.dioClient});

  Future<Response> addUser(String name, String job) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
        data: {
          'name': name,
          'job': job,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUsers() async {
    try {
      final Response response = await dioClient.get(Endpoints.users);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserById(int id, String name, String job) async {
    try {
      final Response response = await dioClient.put(
        '${Endpoints.users}/$id',
        data: {
          'name': name,
          'job': job,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserById(int id) async {
    try {
      await dioClient.delete('${Endpoints.users}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
