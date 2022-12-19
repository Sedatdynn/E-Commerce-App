// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beginer_bloc/views/basket/service/basket_service.dart';

import '../../../core/const/packagesShelf/packages_shelf.dart';
import '../../home/model/home_model.dart';
import 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit(
    this.generalService,
  ) : super(BasketInitial());
  final IGeneralBasketService generalService;

  List<Products> allProduct = [];
  double allinBasket = 0.0;
  bool isLoading = false;

  Future<void> fetchAllProduct() async {
    final a = (await generalService.fetchProductItems()) ?? [];

    try {
      allProduct = a;
      emit(BasketLoaded(allProduct));
    } catch (e) {
      rethrow;
      // emit(HomeError(e.toString()));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(BasketLoading(isLoading));
  }
}
