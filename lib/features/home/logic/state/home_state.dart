import 'package:mini_ecommerce_app/features/home/model/product.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  const HomeSuccess(this.products);

  final List<Product> products;
}

final class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;
}
