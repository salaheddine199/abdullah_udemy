import 'package:abdullah_mansour/models/shop_app/user_data_model.dart';
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
