// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBasketballPlayerAdapter extends TypeAdapter<HiveBasketballPlayer> {
  @override
  final typeId = 0;

  @override
  HiveBasketballPlayer read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBasketballPlayer(
      name: fields[10] as String,
    )
      ..id = fields[0] as String
      ..isUnread = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveBasketballPlayer obj) {
    writer
      ..writeByte(3)
      ..writeByte(10)
      ..write(obj.name)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isUnread);
  }
}
