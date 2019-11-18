import 'package:flutter/material.dart';

class Pizza {
  int id;
  String title;
  String image;
  int price;
  String description;
  
  Pizza({@required this.id, @required this.title, @required this.image, @required this.price, this.description});

}