import 'package:beginer_bloc/views/login/model/login_request_model.dart';
import 'package:beginer_bloc/views/login/model/login_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import '../service/i_login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  bool isLoginFail = false;
  bool isLoading = false;
  final ILoginService service;
  LoginCubit(this.formKey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await service.postUserLogin(LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
      changeLoadingView();

      if (data is LoginResponseModel) {
        emit(LoginComplete(data));
      } else {}
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final LoginResponseModel model;

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
