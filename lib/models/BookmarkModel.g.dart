// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookmarkModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkPhoneAdapter extends TypeAdapter<BookmarkPhone> {
  @override
  final int typeId = 1;

  @override
  BookmarkPhone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkPhone(
      id: fields[0] as int?,
      name: fields[1] as String,
      brand: fields[2] as String,
      price: fields[3] as int,
      img_url: fields[4] as String,
      specification: fields[5] as String,
      createdAt: fields[6] as DateTime?,
      updatedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkPhone obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.img_url)
      ..writeByte(5)
      ..write(obj.specification)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkPhoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
