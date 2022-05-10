// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficePlace _$OfficePlaceFromJson(Map<String, dynamic> json) => OfficePlace(
      id: json['id'] as int,
      available: json['available'] as bool? ?? true,
    );

Map<String, dynamic> _$OfficePlaceToJson(OfficePlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'available': instance.available,
    };
