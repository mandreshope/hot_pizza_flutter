// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final typeId = 0;

  @override
  CartItemModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as double,
      fields[4] as String,
      (fields[5] as List)?.cast<IngredientModel>(),
      fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.ingredient)
      ..writeByte(6)
      ..write(obj.date);
  }
}
