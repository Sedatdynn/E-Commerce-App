import 'package:beginer_bloc/views/home/model/home_model.dart';
import 'package:beginer_bloc/views/home/view/detail_view.dart';
import 'package:beginer_bloc/core/extension/const/border/border_radi.dart';
import 'package:beginer_bloc/core/extension/const/responsive/responsive.dart';
import 'package:beginer_bloc/views/home/viewModel/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String welcomeText = "Welcome to\nE-Commerce App";
  bool isSelected = false;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      if (state is HomeInitial || state is HomeLoading) {
        return const LoadingView();
      } else if (state is HomeItemsLoaded) {
        return buildBody(
            context, welcomeText, context.watch<HomeCubit>().allProduct);
      } else if (state is HomeError) {
        return const ErrorView();
      }
      return const Text("");
    });
  }

  Scaffold buildBody(
      BuildContext context, String welcomeText, List<ProductModel> items) {
    return Scaffold(
        body: Padding(
      padding: context.minAllPadding,
      child: Column(
        children: [
          welcomeField(context, welcomeText),
          SizedBox(
            height: context.height * 0.80,
            child: gridViewBuildField(context, items),
          )
        ],
      ),
    ));
  }

  GridView gridViewBuildField(BuildContext context, List<ProductModel> items) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: context.height * 0.3,
        maxCrossAxisExtent: context.height * 0.4,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailView(items: [items[index]]),
            ));
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadi.extremeLowCircular,
            ),
            child: Stack(
              children: [
                productCardField(items, index, context),
                selectButtonField(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned selectButtonField(BuildContext context) {
    return Positioned(
      right: context.height * 0.01,
      top: context.height * 0.01,
      child: Container(
        height: context.height * 0.06,
        decoration: BoxDecoration(
            color: Colors.greenAccent.shade100,
            borderRadius: BorderRadi.extremeLowCircular),
        child: IconButton(
            onPressed: (() {
              setState(() {
                isSelected = !isSelected;
              });
            }),
            icon: isSelected
                ? const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.purple,
                  )
                : const Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.purple,
                  )),
      ),
    );
  }

  Card productCardField(
      List<ProductModel> items, int index, BuildContext context) {
    const String price = "Urun fiyati:";
    return Card(
      color: Colors.orange.shade100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadi.extremeLowCircular,
              child: Image.network(
                items[index].image.toString(),
                height: context.height * 0.15,
              )),
          Expanded(
            child: Padding(
              padding: context.minAllPadding,
              child: Text(
                items[index].title!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.grey.shade600),
              ),
            ),
          ),
          Padding(
            padding: context.minHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.grey.shade600),
                ),
                Text(
                  items[index].price.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container welcomeField(BuildContext context, String welcomeText) {
    return Container(
      width: context.width,
      height: context.height * 0.15,
      decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(55), topLeft: Radius.circular(55))),
      child: Center(
        child: Text(
          welcomeText,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final data = "Something wrong";
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
