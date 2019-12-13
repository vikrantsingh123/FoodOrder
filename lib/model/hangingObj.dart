import 'package:flutter/material.dart';

class HangingObject {
  String title;
  String subTitle;
  Image image;
  String logo;
  String description;
  String restaurantName;
  List<String> dishes;
  String location;
  HangingObject(this.title, this.logo, this.subTitle, this.image,
      this.restaurantName, this.dishes, this.location);
}
