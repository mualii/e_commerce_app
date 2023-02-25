part of 'products_model.dart';

class ProductResultsAdapter extends TypeAdapter<ProductResults> {
  @override
  final int typeId = 0;

  @override
  ProductResults read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductResults(
      name: fields[1] as String?,
      imageLink: fields[2] as String?,
      price: fields[3] as String?,
      description: fields[4] as String?,
      rate: fields[5] as String?,
      isFav: fields[6] as bool?,
      inCart: fields[7] as bool?,
      quantity: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductResults obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageLink)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.rate)
      ..writeByte(6)
      ..write(obj.isFav)
      ..writeByte(7)
      ..write(obj.inCart)
      ..writeByte(8)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
