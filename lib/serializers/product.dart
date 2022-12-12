import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'user.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name: '_id')
  late String id;
  late String title;
  late int price;
  String? description;
  Category category;
  User? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    required this.category,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() => capitalize(title);
}

String capitalize(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " " && cap == true) {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
      cap = false;
    }
  }
  return result;
}
