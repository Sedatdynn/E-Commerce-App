import 'package:beginer_bloc/views/login/model/login_request_model.dart';
import 'package:beginer_bloc/views/login/model/login_response_model.dart';
import 'package:dio/dio.dart';

abstract class ILoginService {
  final Dio dio;
  final String loginPath = ILoginServicePath.login.rawValue;
  ILoginService(this.dio);
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model);
}

enum ILoginServicePath { login }

extension ILoginServicePathExtension on ILoginServicePath {
  String get rawValue {
    switch (this) {
      case ILoginServicePath.login:
        return "/login";
    }
  }
}
