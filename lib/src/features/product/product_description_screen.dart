import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/router/app_route_name.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/home/model/product_model.dart';
import 'package:klassy_cafe/src/features/product/widget/favorite_icon.dart';
import 'package:klassy_cafe/src/features/product/widget/product_image_swiper.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDescriptionScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 23,
            color: AppColors.kDD000000,
            letterSpacing: 1,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.kDD000000),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return false;
                },
                child: ListView(
                  children: [
                    ProductImageSwiper(images: product.image),
                    Padding(
                      padding: const EdgeInsets.only(top: 10) +
                          const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kDD000000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        product.desc,
                        style: const TextStyle(
                          fontSize: 17,
                          color: AppColors.k89000000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Rs. ${product.price.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  FavoriteIcon(id: product.id),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteName.reservationRoute);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kDD000000,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            AppStrings.makeReservation,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
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
