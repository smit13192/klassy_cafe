import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';

class ProductImageSwiper extends StatefulWidget {
  final List<dynamic> images;
  const ProductImageSwiper({required this.images, super.key});

  @override
  State<ProductImageSwiper> createState() => _ProductImageSwiperState();
}

class _ProductImageSwiperState extends State<ProductImageSwiper> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                index = value;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.network(
                  widget.images[index].toString(),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned.fill(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                widget.images.length,
                (i) => Container(
                  height: 12,
                  width: 12,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == index ? AppColors.k607D8B : AppColors.white,
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
