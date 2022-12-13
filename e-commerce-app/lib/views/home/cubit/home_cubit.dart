// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:beginer_bloc/views/home/service/home_service.dart';

import '../model/home_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(
    this.generalService,
  ) : super(HomeInitial());
  final IGeneralService generalService;

  List<Products> allProduct = [];
  Future<void> fetchAllProduct() async {
    final a = (await generalService.fetchProductItems()) ?? [];
    print(allProduct.toString());
    try {
      allProduct = a;
      emit(HomeItemsLoaded(allProduct));
    } catch (e) {
      rethrow;
      // emit(HomeError(e.toString()));
    }
  }
}

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeItemsLoaded extends HomeStates {
  final List<Products> items;
  HomeItemsLoaded(this.items);
}

class HomeError extends HomeStates {
  final String message;

  HomeError(this.message);
}
