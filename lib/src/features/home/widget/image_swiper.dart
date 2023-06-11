import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';

class AppImageSwiper extends StatefulWidget {
  final List<String> images;
  const AppImageSwiper({required this.images, super.key});

  @override
  State<AppImageSwiper> createState() => _AppImageSwiperState();
}

class _AppImageSwiperState extends State<AppImageSwiper> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Swiper(
            viewportFraction: 0.9,
            onIndexChanged: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            autoplay: true,
            autoplayDelay: 2000,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemCount: widget.images.length,
          ),
          Positioned.fill(
            bottom: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  margin: const EdgeInsets.all(5),
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? AppColors.k607D8B
                        : AppColors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
