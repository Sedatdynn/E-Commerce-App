import 'package:beginer_bloc/core/const/packagesShelf/packages_shelf.dart';
import 'package:beginer_bloc/core/const/responsive/responsive.dart';
import 'package:beginer_bloc/views/basket/cubit/basket_cubit.dart';
import 'package:flutter/material.dart';

import '../../../product/widget/error_message.dart';
import '../../../product/widget/loading_view.dart';
import '../../home/model/home_model.dart';
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

  Scaffold buildBody(BuildContext context, List<Products> items) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.dynamicHeight(0.75),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Text(items[index].title.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
