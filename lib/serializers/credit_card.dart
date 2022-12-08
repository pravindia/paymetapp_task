import 'package:flutter/material.dart';
import 'users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_card.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CreditCard {
  late int id;
  late String name;
  late String cardnumber;
  late String cardtype;
  late String validtill;
  late double balance;

  @JsonKey(defaultValue: <Users>[])
  List<Users> users = [];

  CreditCard({
    required this.id,
    required this.name,
    required this.cardnumber,
    required this.cardtype,
    required this.validtill,
    required this.balance,
    required this.users,
  });
  factory CreditCard.fromJson(Map<String, dynamic> json) => _$CreditCardFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardToJson(this);

  Color getColor() {
    switch (cardtype) {
      case 'visa':
        return Colors.green.shade100;
      case 'maestro':
        return Colors.deepOrange.shade100;
      case 'mastercard':
        return Colors.blue.shade100;
      default:
        return Colors.pink.shade100;
    }
  }
}
