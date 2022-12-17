// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beginer_bloc/views/home/model/user_model.dart';
import 'package:bloc/bloc.dart';

import 'package:beginer_bloc/views/home/service/home_service.dart';

import '../model/home_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(
    this.generalService,
  ) : super(HomeInitial());
  final IGeneralService generalService;

  List<Products> allProduct = [];

  late int proId = 0;
  bool? isinBasket;
  GetUserModel? userData;
  Future<void> fetchAllProduct() async {
    final a = (await generalService.fetchProductItems()) ?? [];
    final b = await generalService.getUser();

    try {
      allProduct = a;
      userData = b;
      emit(HomeItemsLoaded(allProduct,
          userData: userData, proId: proId, isinBasket: false));
    } catch (e) {
      rethrow;
      // emit(HomeError(e.toString()));
    }
  }

  Future<void> basketProduct() async {
    final basketPost = await generalService.postBasket(proId);
    final b = await generalService.getUser();
    try {
      isinBasket = basketPost;
      userData = b;
      emit(HomeItemsLoaded(allProduct,
          userData: userData, proId: proId, isinBasket: isinBasket));
    } catch (e) {
      rethrow;
      // emit(HomeError(e.toString()));
    }
  }

  Future<void> deletebasketProduct() async {
    final basketPost = await generalService.deleteBasket(proId);
    final b = await generalService.getUser();
    try {
      userData = b;
      isinBasket = basketPost;
      emit(HomeItemsLoaded(allProduct,
          userData: userData, proId: proId, isinBasket: isinBasket));
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
  final GetUserModel? userData;
  final int proId;
  final bool? isinBasket;
  HomeItemsLoaded(this.items,
      {required this.userData, required this.proId, required this.isinBasket});
}

class HomeError extends HomeStates {
  final String message;

  HomeError(this.message);
}
