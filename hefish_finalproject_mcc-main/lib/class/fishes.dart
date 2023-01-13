import 'package:flutter/cupertino.dart';
import 'package:hefish_finalproject/class/fish_type.dart';

class Fishes {
  int id;
  int user_id;
  String authorName = "Unknown";
  int fish_type_id;
  String typeName = "Undifined";

  String name = "NULL";
  String price = "0,00";
  String image_path;
  String description;

  Fishes(
      {required this.id,
      required this.user_id,
      required this.authorName,
      required this.fish_type_id,
      required this.typeName,
      required this.name,
      required this.price,
      required this.image_path,
      required this.description});

  factory Fishes.fromJson(Map<String, dynamic> json) {
    return Fishes(
      id: json['fish_id'] as int,
      user_id: json['user_id'] as int,
      authorName: json['username'].toString(),
      fish_type_id: json['fish_type_id'] as int,
      typeName: json['name'].toString(),
      name: json['fish_name'].toString(),
      price: json['price'].toString(),
      image_path: json['image_path'].toString(),
      description: json['description'].toString(),
    );
  }
}
