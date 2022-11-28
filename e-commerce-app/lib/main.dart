import 'package:beginer_bloc/views/home/view/home_view.dart';
import 'package:beginer_bloc/service/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/home/service/home_service.dart';
import 'views/home/viewModel/home_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        String productText = "products";
        return HomeCubit(
            GeneralService(ProjectNetworkManager.instance.service, productText))
          ..fetchAllProduct();
      },
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
          home: const HomeView()),
    );
  }
}
