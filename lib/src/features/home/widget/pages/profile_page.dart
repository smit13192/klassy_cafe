import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/router/app_route_name.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/home/service/firebase_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.kFF8C00,
                radius: 40,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello ,',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.kFF8C00,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColors.kFF8C00,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          color: AppColors.kFF8C00,
          thickness: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, RouteName.offerRoute),
          leading: const Icon(
            Icons.discount_outlined,
            color: AppColors.kFF8C00,
          ),
          title: const Text(
            AppStrings.offerLabel,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColors.kFF8C00,
            ),
          ),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, RouteName.favoriteRoute),
          leading: const Icon(
            Icons.favorite_border_outlined,
            color: AppColors.kFF8C00,
          ),
          title: const Text(
            AppStrings.favoriteLabel,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColors.kFF8C00,
            ),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.email_outlined,
            color: AppColors.kFF8C00,
          ),
          title: Text(
            AppStrings.emailLabel,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColors.kFF8C00,
            ),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.info_outline_rounded,
            color: AppColors.kFF8C00,
          ),
          title: Text(
            AppStrings.aboutLabel,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColors.kFF8C00,
            ),
          ),
        ),
        ListTile(
          onTap: () => FirebaseService.instance().logOut(),
          leading: const Icon(
            Icons.logout,
            color: AppColors.kFF8C00,
          ),
          title: const Text(
            AppStrings.logOut,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColors.kFF8C00,
            ),
          ),
        ),
      ],
    );
  }
}
