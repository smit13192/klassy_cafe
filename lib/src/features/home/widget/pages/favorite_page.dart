import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/router/app_route_name.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/home/service/firebase_service.dart';
import 'package:klassy_cafe/src/features/home/widget/product_tile.dart';
import 'package:klassy_cafe/src/features/product/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.favoriteId.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.favoriteProductIsEmpty,
                style: TextStyle(
                  color: AppColors.kFF8C00,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              mainAxisSpacing: 5,
              childAspectRatio: 0.60,
            ),
            itemCount: provider.favoriteId.length,
            itemBuilder: (context, index) {
              String id = provider.favoriteId.elementAt(index);
              return FutureBuilder(
                future: FirebaseService.instance().readProduct(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            RouteName.productDescriptionRoute,
                            arguments: snapshot.data!,
                          ),
                          child: ProductTile(product: snapshot.data!),
                        ),
                        Positioned(
                          right: 30,
                          top: 20,
                          child: GestureDetector(
                            onTap: () =>
                                context.read<FavoriteProvider>().removeLike(id),
                            child: const Icon(
                              Icons.favorite,
                              color: AppColors.kF44336,
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
