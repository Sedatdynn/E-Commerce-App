import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            // autovalidateMode: state is LoginValidateState
            //     ? (state.isValidate
            //         ? AutovalidateMode.always
            //         : AutovalidateMode.disabled)
            //     : AutovalidateMode.disabled,
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
                registerButton()
              ],
            ),
          ),
        ),
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

  Widget registerButton() {
    return Center(
      child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.login),
          label: const Text("Register")),
    );
  }

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
