import 'dart:io';

import 'package:login_bloc_with_rive/constant/enum/network_enums.dart';
import 'package:login_bloc_with_rive/models/req/login_model.dart';
import 'package:login_bloc_with_rive/models/res/auth_res.dart';
import 'package:login_bloc_with_rive/service/interface_auth_service.dart';

class AuthService extends IAuthService {
  AuthService(super.dioManager);

  @override
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    print(NetworkEnums.login.path);
    var response = await dioManager.dio.post(
      NetworkEnums.login.path,
      data: LoginModel(
        email: email,
        password: password,
      ).toJson(),
    );
    print(response.statusCode);
    print(HttpStatus.ok);
    print(response.statusCode == HttpStatus.ok);
    if (response.statusCode == HttpStatus.ok) {
      return AuthModel.fromJson(response.data).token;
      // return LoginRes.fromJson(response.data).data;

    } else {
      return throw Exception();
    }
  }
}
