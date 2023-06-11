import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int bottomNavigationIndex;
  final Function(int) onTabChanged;

  const MyBottomNavigationBar({
    required this.onTabChanged,
    required this.bottomNavigationIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      child: GNav(
        selectedIndex: bottomNavigationIndex,
        onTabChange: onTabChanged,
        tabBackgroundColor: AppColors.kFF8C00,
        activeColor: AppColors.black,
        color: AppColors.kFF8C00,
        padding: const EdgeInsets.all(15),
        gap: 8,
        tabs: [
          GButton(
            icon: bottomNavigationIndex == 0 ? Icons.home : Icons.home_outlined,
            text: AppStrings.home,
          ),
          GButton(
            icon: bottomNavigationIndex == 1
                ? Icons.discount
                : Icons.discount_outlined,
            text: AppStrings.offer,
          ),
          GButton(
            icon: bottomNavigationIndex == 2
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            text: AppStrings.favorite,
          ),
          GButton(
            icon: bottomNavigationIndex == 0
                ? Icons.account_circle_outlined
                : Icons.account_circle_sharp,
            text: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}
