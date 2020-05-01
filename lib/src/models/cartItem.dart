import 'package:hive/hive.dart';
import 'package:hot_pizza/src/models/ingredient.dart';

part 'cartItem.g.dart';

@HiveType(typeId: 0)
class CartItemModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  double price;

  @HiveField(4)
  String image;

  @HiveField(5)
  List<IngredientModel> ingredient;

  @HiveField(6)
  DateTime date;


  CartItemModel(this.id, this.title, this.quantity, this.price, this.image, this.ingredient, this.date); 

}