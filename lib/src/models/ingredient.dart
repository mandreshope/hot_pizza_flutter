
import 'package:hive/hive.dart';
part 'ingredient.g.dart';

@HiveType(typeId: 1)
class IngredientModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String image;

  @HiveField(3)
  int price;
  
  IngredientModel(this.id, this.title, this.image, this.price);

}