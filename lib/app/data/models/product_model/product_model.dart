import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:json_annotation/json_annotation.dart';

import 'rating.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  const ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating)';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return _$ProductModelFromJson(json);
  }

  static List<ProductModel> listFromJson(list) =>
      List<ProductModel>.from(list.map((x) => ProductModel.fromJson(x)));

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      description.hashCode ^
      category.hashCode ^
      image.hashCode ^
      rating.hashCode;
}
