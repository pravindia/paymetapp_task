// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) => CreditCard(
      id: json['id'] as int,
      name: json['name'] as String,
      cardnumber: json['cardnumber'] as String,
      cardtype: json['cardtype'] as String,
      validtill: json['validtill'] as String,
      balance: (json['balance'] as num).toDouble(),
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => Users.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cardnumber': instance.cardnumber,
      'cardtype': instance.cardtype,
      'validtill': instance.validtill,
      'balance': instance.balance,
      'users': instance.users.map((e) => e.toJson()).toList(),
    };
