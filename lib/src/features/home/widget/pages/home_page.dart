import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/router/app_route_name.dart';
import 'package:klassy_cafe/src/features/home/service/firebase_service.dart';
import 'package:klassy_cafe/src/features/home/widget/image_swiper.dart';
import 'package:klassy_cafe/src/features/home/widget/product_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder<List<String>>(
              stream: FirebaseService.instance().getSwiperPhoto(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AppImageSwiper(images: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseService.instance().getProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.productDescriptionRoute,
                            arguments: snapshot.data![index],
                          );
                        },
                        child: ProductTile(product: snapshot.data![index]),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.60,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    'Error',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
