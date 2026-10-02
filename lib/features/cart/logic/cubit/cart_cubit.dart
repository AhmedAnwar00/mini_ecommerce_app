import 'package:bloc/bloc.dart';
import 'package:mini_ecommerce_app/features/cart/logic/state/cart_state.dart';
import 'package:mini_ecommerce_app/features/cart/model/cart_item.dart';
import 'package:mini_ecommerce_app/features/home/model/product.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  double get totalPrice {
    var total = 0.0;
    for (final item in state.items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  int get totalItems {
    var total = 0;
    for (final item in state.items) {
      total += item.quantity;
    }
    return total;
  }

  void addToCart(Product product) {
    final index = _indexOf(product);
    if (index == -1) {
      _emitItems([
        ...state.items,
        CartItem(product: product, quantity: 1),
      ]);
      return;
    }
    _replaceQuantity(index, state.items[index].quantity + 1);
  }

  void increaseQuantity(Product product) {
    final index = _indexOf(product);
    if (index == -1) {
      return;
    }
    _replaceQuantity(index, state.items[index].quantity + 1);
  }

  void decreaseQuantity(Product product) {
    final index = _indexOf(product);
    if (index == -1) {
      return;
    }
    final nextQuantity = state.items[index].quantity - 1;
    if (nextQuantity == 0) {
      removeFromCart(product);
      return;
    }
    _replaceQuantity(index, nextQuantity);
  }

  void removeFromCart(Product product) {
    _emitItems([
      for (final item in state.items)
        if (item.product.id != product.id) item,
    ]);
  }

  int _indexOf(Product product) {
    return state.items.indexWhere((item) => item.product.id == product.id);
  }

  void _replaceQuantity(int index, int quantity) {
    _emitItems([
      for (var i = 0; i < state.items.length; i++)
        if (i == index)
          CartItem(product: state.items[i].product, quantity: quantity)
        else
          state.items[i],
    ]);
  }

  void _emitItems(List<CartItem> items) {
    emit(CartState(items: List.unmodifiable(items)));
  }
}
