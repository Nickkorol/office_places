// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResult _$BookingResultFromJson(Map<String, dynamic> json) =>
    BookingResult(
      id: json['id'] as int,
      officeName: json['office_name'] as String,
      placeId: json['place_id'] as int,
      bookingDate: json['booking_date'] as int,
    );

Map<String, dynamic> _$BookingResultToJson(BookingResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'office_name': instance.officeName,
      'place_id': instance.placeId,
      'booking_date': instance.bookingDate,
    };
