import 'package:dio/dio.dart';
import 'package:myntra/core/network/network.dart';

class LoginRepo {
  Dio client = Dio();

  Future<Result> userLogin(
    final String username,
    final String password,
  ) async {
    try {
      final response = await client.post(ApiUris.loginUri, data: {
        'username': 'mor_2314',
        'password': '83r5^_',
      });
      if (response.statusCode == 200) {
        return Result.success(response.data);
      } else {
        return Result.failure('Api fetching failed');
      }
    } catch (e) {
      return Result.failure('An error occurred');
    }
  }
}
