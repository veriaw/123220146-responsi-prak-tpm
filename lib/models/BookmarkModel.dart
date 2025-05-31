import 'package:hive/hive.dart';

part 'BookmarkModel.g.dart';

@HiveType(typeId: 1)
class BookmarkPhone extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String brand;

  @HiveField(3)
  int price;

  @HiveField(4)
  String img_url;

  @HiveField(5)
  String specification;

  @HiveField(6)
  DateTime? createdAt;

  @HiveField(7)
  DateTime? updatedAt;

  BookmarkPhone({
    this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.img_url,
    required this.specification,
    this.createdAt,
    this.updatedAt,
  });
}