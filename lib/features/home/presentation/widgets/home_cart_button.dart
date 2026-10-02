import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/core/routes/app_routes.dart';

class HomeCartButton extends StatelessWidget {
  const HomeCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
      icon: const Icon(Icons.shopping_cart),
    );
  }
}
