import 'package:hive_flutter/adapters.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String image;
  @HiveField(5)
    int quantity;

  CartModel({
    required this.title,
    required this.price,
    required this.image,
    required this.id,
    required this.quantity,
  });
}
