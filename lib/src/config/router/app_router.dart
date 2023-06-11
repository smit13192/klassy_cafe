import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/router/app_route_name.dart';
import 'package:klassy_cafe/src/features/auth/auth_support.dart';
import 'package:klassy_cafe/src/features/home/home_screen.dart';
import 'package:klassy_cafe/src/features/home/model/product_model.dart';
import 'package:klassy_cafe/src/features/home/widget/pages/favorite_page.dart';
import 'package:klassy_cafe/src/features/home/widget/pages/offer_page.dart';
import 'package:klassy_cafe/src/features/product/product_description_screen.dart';
import 'package:klassy_cafe/src/features/reservation/reservation_screen.dart';
import 'package:klassy_cafe/src/features/splash/splash_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.authRoute:
        return MaterialPageRoute(builder: (context) => const AuthSupport());

      case RouteName.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RouteName.productDescriptionRoute:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => ProductDescriptionScreen(product: product),
        );

      case RouteName.offerRoute:
        return MaterialPageRoute(builder: (context) => const OfferPage());

      case RouteName.favoriteRoute:
        return MaterialPageRoute(builder: (context) => const FavoritePage());

      case RouteName.reservationRoute:
        return MaterialPageRoute(
          builder: (context) => const ReservationScreen(),
        );

      default:
        return null;
    }
  }
}
