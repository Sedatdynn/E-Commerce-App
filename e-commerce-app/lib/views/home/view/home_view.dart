import 'package:beginer_bloc/views/basket/cubit/basket_cubit.dart';
import 'package:beginer_bloc/views/basket/view/basket_view.dart';
import 'package:beginer_bloc/views/home/model/home_model.dart';
import 'package:beginer_bloc/views/home/model/user_model.dart';
import 'package:beginer_bloc/views/home/view/detail_view.dart';
import 'package:beginer_bloc/core/const/border/border_radi.dart';
import 'package:beginer_bloc/core/const/responsive/responsive.dart';
import 'package:beginer_bloc/views/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/widget/error_message.dart';
import '../../../product/widget/loading_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String welcomeText = "Welcome \n";
  final String basketText = "Basket";
  final String price = "Product price:";

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      if (state is HomeInitial || state is HomeLoading) {
        return const LoadingView();
      } else if (state is HomeItemsLoaded) {
        return buildBody(
            context, welcomeText, context.read<HomeCubit>().allProduct);
      } else if (state is HomeError) {
        return const ErrorView();
      }
      return const Center(child: Text("aaaaaaaa"));
    });
  }

  Scaffold buildBody(
      BuildContext context, String welcomeText, List<Products> items) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: context.minAllPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                welcomeField(context, welcomeText),
                SizedBox(
                  height: context.dynamicHeight(0.80),
                  child: gridViewBuildField(context, items),
                )
              ],
            ),
          ),
        ));
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size.zero,
      child: AppBar(
        backgroundColor: Colors.transparent,
      ),
    );
  }

  GridView gridViewBuildField(BuildContext context, List<Products> items) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: context.dynamicHeight(0.3),
        maxCrossAxisExtent: context.dynamicHeight(0.4),
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final a = context.watch<HomeCubit>().userData!.basket;
        final List<int?> b = [];
        for (var i = 0; i < a!.length; i++) {
          b.add(a[i].pId! - 1);
        }

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
                Positioned(
                  right: context.dynamicHeight(0.01),
                  top: context.dynamicHeight(0.01),
                  child: Container(
                      height: context.dynamicHeight(0.06),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadi.extremeLowCircular),
                      child: BlocConsumer<HomeCubit, HomeStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return IconButton(
                              onPressed: (() async {
                                b.clear();
                                for (var i = 0; i < a.length; i++) {
                                  b.add(a[i].pId! - 1);
                                }
                                if (b.contains(index)) {
                                  context.read<HomeCubit>().proId = index + 1;
                                  await context
                                      .read<HomeCubit>()
                                      .deletebasketProduct();
                                  setState(() {
                                    items[index].isSelected =
                                        !items[index].isSelected!;
                                  });
                                } else {
                                  context.read<HomeCubit>().proId = index + 1;
                                  await context
                                      .read<HomeCubit>()
                                      .basketProduct();
                                  context.read<HomeCubit>().isinBasket!
                                      ? setState(() {
                                          items[index].isSelected =
                                              !items[index].isSelected!;
                                        })
                                      : debugPrint("hey error basket!!");
                                }
                              }),
                              icon: b.contains(index)
                                  ? const Icon(
                                      Icons.shopping_cart_rounded,
                                      color: Colors.purple,
                                    )
                                  : const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.purple,
                                    ));
                        },
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Card productCardField(List<Products> items, int index, BuildContext context) {
    return Card(
      color: Colors.orange.shade100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadi.extremeLowCircular,
              child: Image.network(
                items[index].images![0].toString(),
                fit: BoxFit.fill,
                height: context.dynamicHeight(0.2),
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
                  "${items[index].price.toString()} €",
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
    final GetUserModel? userData = context.watch<HomeCubit>().userData;

    return Container(
      padding: context.midAllPadding,
      width: context.width,
      height: context.dynamicHeight(0.15),
      decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(55), topLeft: Radius.circular(55))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$welcomeText ${userData!.username.toString()}",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
                onPressed: () {
                  context.read<BasketCubit>().fetchAllProduct();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BasketView(),
                      ));
                },
                icon: const Icon(Icons.shopping_cart_sharp),
                label: Text(basketText))
          ],
        ),
      ),
    );
  }
}
