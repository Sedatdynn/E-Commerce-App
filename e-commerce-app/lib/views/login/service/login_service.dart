import 'dart:io';

import 'package:beginer_bloc/views/login/model/login_response_model.dart';
import 'package:beginer_bloc/views/login/model/login_request_model.dart';
import 'package:beginer_bloc/views/login/service/i_login_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends ILoginService {
  LoginService(super.dio, super.item);

  @override
  Future<bool?> postUserLogin(
    Map<String, dynamic> loginData,
  ) async {
    try {
      final response = await dio.post(item, data: {
        "username": loginData["username"],
        "password": loginData["password"]
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
