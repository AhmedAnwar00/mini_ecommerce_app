import 'package:bloc/bloc.dart';
import 'package:mini_ecommerce_app/features/home/logic/state/home_state.dart';
import 'package:mini_ecommerce_app/features/home/model/data/mock/products.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  void loadProducts() {
    emit(const HomeLoading());
    try {
      emit(const HomeSuccess(mockProducts));
    } catch (_) {
      emit(const HomeError('Failed to load products'));
    }
  }
}
