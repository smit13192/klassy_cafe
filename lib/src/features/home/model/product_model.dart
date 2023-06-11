import 'package:flutter/material.dart';

@immutable
class ProductModel {
  final String id;
  final String title;
  final String desc;
  final String type;
  final int price;
  final List<dynamic> image;

  const ProductModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.type,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(String id,Map<String, dynamic> json) {
    return ProductModel(
      id: id,
      title: json['title'],
      desc: json['desc'],
      type: json['type'],
      price: json['price'],
      image: json['image'] as List<dynamic>, 
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'type': type,
        'price': price,
        'image': image,
      };
}
