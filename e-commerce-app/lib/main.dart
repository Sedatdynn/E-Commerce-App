import 'package:beginer_bloc/core/const/packagesShelf/packages_shelf.dart';
import 'package:beginer_bloc/views/basket/cubit/basket_cubit.dart';
import 'package:beginer_bloc/views/basket/service/basket_service.dart';
import 'package:beginer_bloc/views/home/home_shelf.dart';
import 'package:beginer_bloc/views/login/view/login_view.dart';
import 'service/network_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            String productText = "products";
            return HomeCubit(GeneralService(
                ProjectNetworkManager.instance.service, productText))
              ..fetchAllProduct();
          },
        ),
        BlocProvider(
          create: (context) => BasketCubit(
              GeneralBasketService(ProjectNetworkManager.instance.service)),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.purple,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            tabBarTheme: TabBarTheme(
                labelColor: Colors.purple,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator:
                    BoxDecoration(borderRadius: BorderRadius.circular(200))),
            primarySwatch: Colors.purple,
          ),
          home: LoginView()),
    );
  }
}
