import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/home/widget/bottom_navigation.dart';
import 'package:klassy_cafe/src/features/home/widget/pages/favorite_page.dart';
import 'package:klassy_cafe/src/features/home/widget/pages/home_page.dart';
import 'package:klassy_cafe/src/features/home/widget/pages/offer_page.dart';
import 'package:klassy_cafe/src/features/home/widget/pages/profile_page.dart';
import 'package:klassy_cafe/src/features/product/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteProvider>().getAllFavoriteProductId();
  }

  int bottomNavigationIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const OfferPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 23,
            color: AppColors.kFF8C00,
            letterSpacing: 1,
          ),
        ),
      ),
      body: IndexedStack(
        index: bottomNavigationIndex,
        children: pages,
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        bottomNavigationIndex: bottomNavigationIndex,
        onTabChanged: (value) => setState(() => bottomNavigationIndex = value),
      ),
    );
  }
}
