import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:mini_ecommerce_app/features/cart/logic/state/cart_state.dart';
import 'package:mini_ecommerce_app/features/cart/presentation/widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final cartCubit = context.read<CartCubit>();

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CartItemCard(cartItem: state.items[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total items: ${cartCubit.totalItems}',
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      'Total: \$${cartCubit.totalPrice.toStringAsFixed(2)}',
                      style: textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
