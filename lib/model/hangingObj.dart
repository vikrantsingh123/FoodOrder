import 'package:flutter/material.dart';

class HangingObject {
  String title;
  String subTitle;
  String dishImage;
  String logo;
  String description;
  String restaurantName;
  List<String> dishes;
  String location;
  String contact;
  HangingObject(this.title, this.logo, this.subTitle, this.dishImage,
      this.restaurantName, this.dishes, this.location, this.contact);
}
