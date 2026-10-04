import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_ecommerce_app/core/utils/price_formatter.dart';
import 'package:mini_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:mini_ecommerce_app/features/home/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return const ColoredBox(
                    color: Color(0xFFE0E0E0),
                    child: Center(child: Icon(Icons.image_not_supported_outlined)),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                context.read<CartCubit>().addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
