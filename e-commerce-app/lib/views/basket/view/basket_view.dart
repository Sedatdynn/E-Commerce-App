import 'package:beginer_bloc/core/const/border/border_radi.dart';
import 'package:beginer_bloc/core/const/packagesShelf/packages_shelf.dart';
import 'package:beginer_bloc/core/const/responsive/responsive.dart';
import 'package:beginer_bloc/views/basket/cubit/basket_cubit.dart';
import 'package:flutter/material.dart';

import '../../../product/widget/error_message.dart';
import '../../../product/widget/loading_view.dart';
import '../../home/model/home_model.dart';
import '../../payment/payment_view.dart';
import '../cubit/basket_state.dart';

class BasketView extends StatefulWidget {
  const BasketView({Key? key}) : super(key: key);
  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(builder: (context, state) {
      if (state is BasketInitial || state is BasketLoading) {
        return const LoadingView();
      } else if (state is BasketLoaded) {
        return buildBody(context, context.read<BasketCubit>().allProduct);
      } else if (state is BasketError) {
        return const ErrorView();
      }
      return const Center(child: Text("aaaaaaaa"));
    });
  }

  buildBody(BuildContext context, List<Products> items) {
    const String addToCard = 'Add to card';
    const String selectProductsToCreateOrder =
        'Select products to create order';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(selectProductsToCreateOrder),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: context.minAllPadding,
        child: buildMainBody(context, items, addToCard),
      ),
    );
  }

  Column buildMainBody(
      BuildContext context, List<Products> items, String addToCard) {
    return Column(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        SizedBox(
          height: context.dynamicHeight(0.60),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    items[index].isSelected = !items[index].isSelected!;
                    if (items[index].isSelected!) {
                      context.read<BasketCubit>().allinBasket +=
                          items[index].price;
                    } else {
                      context.read<BasketCubit>().allinBasket -=
                          items[index].price;
                    }
                  });
                },
                child: buildProductsField(context, items, index),
              );
            },
          ),
        ),
        SizedBox(
          height: context.dynamicHeight(0.05),
        ),
        buildButton(context, addToCard)
      ],
    );
  }

  Container buildProductsField(
      BuildContext context, List<Products> items, int index) {
    return Container(
      padding: context.minAllPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadi.midCircular,
        color: items[index].isSelected!
            ? Colors.orange.shade100
            : Colors.grey.shade300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            items[index].images![0],
            fit: BoxFit.fill,
            height: context.dynamicHeight(0.12),
            width: context.dynamicWidth(0.25),
          ),
          Text(
            items[index].title.toString(),
          ),
          Text("${items[index].price} €")
        ],
      ),
    );
  }

  InkWell buildButton(BuildContext context, String addToCard) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPageView(
              totalFee: context.read<BasketCubit>().allinBasket,
            ),
          )),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadi.midCircular),
        height: context.dynamicHeight(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${context.watch<BasketCubit>().allinBasket} €",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "${addToCard}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
