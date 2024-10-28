import 'dart:convert';

import 'package:ecommerce/models/Rate.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  final int id;
  final String title;
  final num price;
  final String description;
  final String? category;
  final String image;
  final Rate rating;

  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: Rate.fromJson(json['rating']),
      );
}
