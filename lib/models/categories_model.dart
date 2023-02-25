class CategoriesModel {
  CategoriesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  CategoriesModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(CategoriesResults.fromJson(v));
      });
    }
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<CategoriesResults>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoriesResults {
  CategoriesResults({
    this.id,
    this.name,
    this.imageLink,
  });

  CategoriesResults.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    imageLink = json['image_link'];
  }
  int? id;
  String? name;
  String? imageLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image_link'] = imageLink;
    return map;
  }
}
