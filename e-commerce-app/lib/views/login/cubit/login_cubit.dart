// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beginer_bloc/core/const/packagesShelf/packages_shelf.dart';
import 'package:beginer_bloc/service/network_manager.dart';
import 'package:beginer_bloc/views/login/model/login_request_model.dart';
import 'package:beginer_bloc/views/login/model/login_response_model.dart';
import 'package:beginer_bloc/views/login/service/login_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../service/i_login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  LoginService service =
      LoginService(ProjectNetworkManager.instance.service, "/api/user/login/");
  bool isLoginFail = false;
  bool isLoading = false;
  LoginCubit(this.formKey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      bool? data = await service.postUserLogin({
        "username": emailController.text.trim(),
        "password": passwordController.text.trim()
      });

      if (data!) {
        emit(LoginComplete(data));
      } else {}
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
    changeLoadingView();
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final bool? model;

  LoginComplete(this.model);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  bool isLoading;
  LoginLoadingState(this.isLoading);
}
