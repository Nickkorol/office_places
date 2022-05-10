import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:office_places/models/office_place.dart';

part 'office.g.dart';

@JsonSerializable()
class Office {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "places")
  final List<OfficePlace> places;

  const Office({
    required this.id,
    required this.name,
    required this.places,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);
}
