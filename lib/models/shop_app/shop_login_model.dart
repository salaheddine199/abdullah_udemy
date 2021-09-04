import 'package:flutter/cupertino.dart';

class ShopLoginModel {
  bool status;
  String message;
  UserData data;

  // ShopLoginModel({
  //   this.status,
  //   this.message,
  //   this.data,
  // });

  ShopLoginModel.fromJson({@required Map<String, dynamic> json}) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? UserData.fromJson(json: json['data'])
        : null;
  }
}


class UserData {
  int id;
  String name;
  String phone;
  String email;
  //String password;
  String image;
  int credits;
  int points;
  String token;

  // UserData({
  //   this.id,
  //   this.name,
  //   this.phone,
  //   this.email,
  //   this.image,
  //   this.credits,
  //   this.points,
  //   this.token,
  // });

  /// named constructor:
  UserData.fromJson({@required Map<String, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    credits = json['credits'];
    points = json['points'];
    token = json['token'];
  }
}