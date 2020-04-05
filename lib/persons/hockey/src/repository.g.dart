// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveHockeyPlayerAdapter extends TypeAdapter<HiveHockeyPlayer> {
  @override
  final typeId = 1;

  @override
  HiveHockeyPlayer read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveHockeyPlayer(
      alignRight: fields[11] as bool,
      name: fields[10] as String,
    )
      ..id = fields[0] as String
      ..isUnread = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveHockeyPlayer obj) {
    writer
      ..writeByte(4)
      ..writeByte(10)
      ..write(obj.name)
      ..writeByte(11)
      ..write(obj.alignRight)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isUnread);
  }
}
