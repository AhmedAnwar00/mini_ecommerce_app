import 'package:mini_ecommerce_app/features/home/model/product.dart';

class CartItem {
  const CartItem({
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;
}
