import 'package:dio/dio.dart';

class ProjectNetworkManager {
  ProjectNetworkManager._() {
    //https://dummyjson.com
    _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080"));
  }
  late final Dio _dio;

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get service => _dio;
}
