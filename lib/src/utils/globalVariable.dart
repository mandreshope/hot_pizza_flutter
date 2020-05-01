import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const CART_ITEM_BOX = 'cartItemBox';
var bodyColor = Colors.grey[200];
var bosShadowRight = Colors.grey[600];
var shadowLeft = Colors.white;
dynamic getShadow() {
  return [
    BoxShadow(
        color: bosShadowRight,
        offset: Offset(4.0, 4.0),
        blurRadius: 15.0,
        spreadRadius: 4.0),
    BoxShadow(
        color: shadowLeft,
        offset: Offset(-4.0, -4.0),
        blurRadius: 5.0,
        spreadRadius: 4),
  ];
}
final price = new NumberFormat.currency(locale: "fr_FR",
      symbol: "Ar");