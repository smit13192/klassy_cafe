import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/features/home/model/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                product.image[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            'Rs. ${product.price.toString()}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.kFF8C00,
            ),
          ),
        ],
      ),
    );
  }
}
