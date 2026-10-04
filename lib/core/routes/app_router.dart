import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/core/routes/app_routes.dart';
import 'package:mini_ecommerce_app/features/auth/log_in/presentation/screen/login_screen.dart';
import 'package:mini_ecommerce_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:mini_ecommerce_app/features/home/presentation/screen/home_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _page(const LoginScreen(), settings);
      case AppRoutes.home:
        return _page(const HomeScreen(), settings);
      case AppRoutes.cart:
        return _page(const CartScreen(), settings);
      default:
        return _page(const HomeScreen(), settings);
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes(String initialRoute) {
    return [onGenerateRoute(RouteSettings(name: initialRoute))];
  }

  static MaterialPageRoute<void> _page(Widget page, RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => page,
    );
  }
}
