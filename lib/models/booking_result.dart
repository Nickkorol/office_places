import 'package:json_annotation/json_annotation.dart';

part 'booking_result.g.dart';

@JsonSerializable()
class BookingResult {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "office_name")
  final String officeName;
  @JsonKey(name: "place_id")
  final int placeId;
  @JsonKey(name: "booking_date")
  final int bookingDate;

  BookingResult({
    required this.id,
    required this.officeName,
    required this.placeId,
    required this.bookingDate,
  });

  factory BookingResult.fromJson(Map<String, dynamic> json) =>
      _$BookingResultFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResultToJson(this);
}
