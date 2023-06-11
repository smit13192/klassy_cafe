import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/features/product/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteIcon extends StatelessWidget {
  final String id;
  const FavoriteIcon({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            if (provider.favoriteId.contains(id)) {
              context.read<FavoriteProvider>().removeLike(id);
            } else {
              context.read<FavoriteProvider>().addLike(id);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            width: 50,
            child: Center(
              child: provider.favoriteId.contains(id)
                  ? const Icon(
                      Icons.favorite,
                      color: AppColors.kF44336,
                    )
                  : const Icon(Icons.favorite_border_outlined),
            ),
          ),
        );
      },
    );
  }
}
