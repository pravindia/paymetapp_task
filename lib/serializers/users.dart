import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable(explicitToJson: true)
class Users {
  late int id;
  late String name;
  final String category;

  @JsonKey(defaultValue: "https://picsum.photos/200/200")
  String image;

  Users({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

  @override
  String toString() => capitalize(name);
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
