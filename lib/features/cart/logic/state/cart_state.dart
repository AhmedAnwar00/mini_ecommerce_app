import 'package:mini_ecommerce_app/features/cart/model/cart_item.dart';

class CartState {
  const CartState({this.items = const []});

  final List<CartItem> items;
}
