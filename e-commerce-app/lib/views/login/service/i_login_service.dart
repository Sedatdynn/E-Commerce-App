import 'package:beginer_bloc/views/login/model/login_request_model.dart';
import 'package:beginer_bloc/views/login/model/login_response_model.dart';
import 'package:dio/dio.dart';

abstract class ILoginService {
  ILoginService(this.dio, this.item);
  final Dio dio;
  String item;

  Future<bool?> postUserLogin(Map<String, dynamic> loginData);
}
