// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
    )
      ..products =
          (json['products'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..productdata = (json['productdata'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'products': instance.products,
      'productdata': instance.productdata?.map((e) => e.toJson()).toList(),
    };
