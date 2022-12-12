import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  late String role;
  @JsonKey(name: '_id')
  late String id;
  late String name;
  int? number;
  String? email;
  @JsonKey(name: 'password', ignore: true)
  String? _password;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastLoginAt;

  User({
    required this.role,
    required this.id,
    required this.name,
    this.email,
    this.number,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
