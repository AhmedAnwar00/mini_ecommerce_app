import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_ecommerce_app/core/utils/price_formatter.dart';
import 'package:mini_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:mini_ecommerce_app/features/cart/model/cart_item.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final product = cartItem.product;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return const ColoredBox(
                    color: Color(0xFFE0E0E0),
                    child: Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatPrice(product.price),
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartCubit>()
                              .decreaseQuantity(cartItem.product);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text('${cartItem.quantity}', style: textTheme.bodyMedium),
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartCubit>()
                              .increaseQuantity(cartItem.product);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartCubit>()
                              .removeFromCart(cartItem.product);
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
