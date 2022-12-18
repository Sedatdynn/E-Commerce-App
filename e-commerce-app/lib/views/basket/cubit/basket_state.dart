// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../home/model/home_model.dart';

abstract class BasketState {}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {
  bool isLoading;
  BasketLoading(
    this.isLoading,
  );
}

class BasketLoaded extends BasketState {
  final List<Products> items;

  BasketLoaded(this.items);
}

class BasketError extends BasketState {}
