import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Text(
          'Offer is not aviliable',
          style: TextStyle(
            color: AppColors.kFF8C00,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
