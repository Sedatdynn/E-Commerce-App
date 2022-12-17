import 'dart:io';

import 'package:beginer_bloc/views/login/model/login_response_model.dart';
import 'package:beginer_bloc/views/login/model/login_request_model.dart';
import 'package:beginer_bloc/views/login/service/i_login_service.dart';
import 'package:beginer_bloc/views/register/service/i_register_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService extends IRegisterService {
  RegisterService(super.dio, super.item);

  @override
  Future<bool?> postUserRegister(
    Map<String, dynamic> loginData,
  ) async {
    try {
      final response = await dio.post(item, data: {
        "email": loginData["email"],
        "password": loginData["password"],
        "username": loginData["username"],
      });
      if (response.statusCode == HttpStatus.ok) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        final jsonBody = response.data;
        if (jsonBody is Map<String, dynamic>) {
          final tok = LoginResponseModel.fromJson(jsonBody);
          prefs.setString("token", tok.token!);

          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
