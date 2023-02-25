import 'package:hive/hive.dart';

part 'products_model.g.dart';

class ProductsModel {
  ProductsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  ProductsModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(ProductResults.fromJson(v));
      });
    }
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<ProductResults>? results;
}

@HiveType(typeId: 0)
class ProductResults {
  ProductResults(
      {this.id,
      this.name,
      this.imageLink,
      this.price,
      this.description,
      this.rate,
      this.category,
      this.isFav,
      this.inCart,
      this.quantity});

  ProductResults.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    imageLink = json['image_link'];
    price = json['price'];
    description = json['description'];
    rate = json['rate'];
    isFav = false;
    inCart = false;
    quantity = 1;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? imageLink;
  @HiveField(3)
  String? price;
  @HiveField(4)
  String? description;
  @HiveField(5)
  String? rate;
  @HiveField(6)
  bool? isFav;
  @HiveField(7)
  bool? inCart;
  @HiveField(8)
  int? quantity;
  Category? category;
}

class Category {
  Category({
    this.id,
    this.name,
    this.imageLink,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    imageLink = json['image_link'];
  }
  int? id;
  String? name;
  String? imageLink;
}
