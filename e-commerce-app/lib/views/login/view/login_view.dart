import 'package:beginer_bloc/views/login/login_shelf.dart';
import 'package:beginer_bloc/views/register/view/register_view.dart';
import '../../../core/const/packagesShelf/packages_shelf.dart';
import '../../home/home_shelf.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final String appBarTitle = "Cubit Login";
  final String buttonTitle = "Login";
  final String baseUrl = "https://reqres.in/api";
  final String accountText = "Don't have an account?";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          formKey, emailController, passwordController,
          service: LoginService(Dio(BaseOptions(baseUrl: baseUrl)))),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginComplete) {
            state.navigate(context);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: Form(
        key: formKey,
        autovalidateMode: state is LoginValidateState
            ? (state.isValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled)
            : AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailField(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              passwordField(),
              dontHaveAccountText(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget dontHaveAccountText(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterView(),
            ));
      },
      child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            accountText,
            style: const TextStyle(color: Colors.purple),
          )),
    );
  }

  Widget buildButton(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginComplete) {
          return const Card(
            child: Icon(Icons.check),
          );
        }
        return ElevatedButton.icon(
            onPressed: context.watch<LoginCubit>().isLoading
                ? null
                : () {
                    context.read<LoginCubit>().postUserModel();
                  },
            icon: const Icon(Icons.login),
            label: Text(buttonTitle));
      },
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      leading: Visibility(
        visible: context.watch<LoginCubit>().isLoading,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
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
}

extension LoginCompleteExtension on LoginComplete {
  void navigate(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeView() //model: model,
            ));
  }
}
