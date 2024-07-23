import 'package:dars81_dio/data/models/category.dart';

class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final Category category;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      images: List<String>.from(json['images'].map((x) => x as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category.toJson(),
      'images': List<dynamic>.from(images.map((x) => x)),
    };
  }
}
