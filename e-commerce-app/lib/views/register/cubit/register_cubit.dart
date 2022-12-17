// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beginer_bloc/views/register/service/register_service.dart';

import '../../../core/const/packagesShelf/packages_shelf.dart';
import '../../../service/network_manager.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController usernameController;

  final TextEditingController passwordController;
  bool isLoginFail = false;
  bool isLoading = false;
  RegisterService service = RegisterService(
      ProjectNetworkManager.instance.service, "/api/user/register/");
  RegisterCubit(this.formKey, this.emailController, this.usernameController,
      this.passwordController,
      {required this.service})
      : super(RegisterInitial());

  Future<void> postUserRegisterModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      bool? data = await service.postUserRegister({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "username": usernameController.text.trim(),
      });

      if (data!) {
        emit(RegisterLoaded(data));
      } else {}
    } else {
      isLoginFail = true;
      emit(RegisterValidateState(isLoginFail));
    }
    changeLoadingView();
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(RegisterLoading(isLoading));
  }
}
