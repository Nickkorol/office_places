import 'package:json_annotation/json_annotation.dart';

part 'office_place.g.dart';

@JsonSerializable()
class OfficePlace {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "available")
  bool available;

  bool chosen = false;

  OfficePlace({
    required this.id,
    this.available = true,
  });

  factory OfficePlace.fromJson(Map<String, dynamic> json) =>
      _$OfficePlaceFromJson(json);

  Map<String, dynamic> toJson() => _$OfficePlaceToJson(this);

  @override
  bool operator ==(dynamic other) {
    return other.id == id && other.available == available;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;
}
