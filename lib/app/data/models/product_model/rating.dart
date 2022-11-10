import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  final double? rate;
  final int? count;

  const Rating({this.rate, this.count});

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';

  factory Rating.fromJson(Map<String, dynamic> json) {
    return _$RatingFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RatingToJson(this);

  Rating copyWith({
    double? rate,
    int? count,
  }) {
    return Rating(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Rating) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
}
