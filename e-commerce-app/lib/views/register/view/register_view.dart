import 'package:beginer_bloc/views/register/cubit/register_cubit.dart';
import 'package:beginer_bloc/views/register/service/register_service.dart';
import 'package:flutter/material.dart';

import '../../../core/const/packagesShelf/packages_shelf.dart';
import '../../../service/network_manager.dart';
import '../../home/view/home_view.dart';
import '../../login/service/login_service.dart';
import '../cubit/register_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  List<String> items = <String>[DropItems.male.name, DropItems.female.name];
  String? selectedItem = DropItems.male.name;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
          formKey, emailController, passwordController, usernameController,
          service: RegisterService(
              ProjectNetworkManager.instance.service, "/api/user/register/")),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterLoaded) {
            state.navigate(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formKey,
                  autovalidateMode: state is RegisterValidateState
                      ? (state.isValidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled)
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      usernameField(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      emailField(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      passwordField(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      buildDropdownMenu(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoaded) {
                            return const Card(
                              child: Icon(Icons.check),
                            );
                          }
                          return ElevatedButton.icon(
                              onPressed:
                                  context.watch<RegisterCubit>().isLoading
                                      ? null
                                      : () {
                                          context
                                              .read<RegisterCubit>()
                                              .postUserRegisterModel();
                                        },
                              icon: const Icon(Icons.app_registration_outlined),
                              label: Text("Register"));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox buildDropdownMenu(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.7,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 0.2, color: Colors.purple)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 2, color: Colors.grey)),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: (item) {
          setState(() {
            selectedItem = item;
          });
        },
        value: selectedItem,
      ),
    );
  }

  // Widget registerButton() {
  //   return Center(
  //     child: ElevatedButton.icon(
  //         onPressed: () {},
  //         icon: const Icon(Icons.login),
  //         label: const Text("Register")),
  //   );
  // }
  // Widget registerButton(BuildContext context) {
  //   return
  // }

  TextFormField passwordField() {
    return TextFormField(
      validator: (value) => (value ?? "").length > 5 ? null : "5ten kucuk",
      controller: passwordController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "password"),
    );
  }

  TextFormField emailField() {
    return TextFormField(
      validator: (value) => (value ?? "").length > 6 ? null : "6 dan kucuk",
      controller: emailController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "email"),
    );
  }

  TextFormField usernameField() {
    return TextFormField(
      validator: (value) => (value ?? "").length > 6 ? null : "6 dan kucuk",
      controller: usernameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "username"),
    );
  }
}

enum DropItems { female, male }

extension LoginCompleteExtension on RegisterLoaded {
  void navigate(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeView() //model: model,
            ));
  }
}
