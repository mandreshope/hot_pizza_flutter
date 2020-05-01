// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientModelAdapter extends TypeAdapter<IngredientModel> {
  @override
  final typeId = 1;

  @override
  IngredientModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price);
  }
}
