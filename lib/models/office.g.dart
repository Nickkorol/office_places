// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      id: json['id'] as int,
      name: json['name'] as String,
      places: (json['places'] as List<dynamic>)
          .map((e) => OfficePlace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'places': instance.places,
    };
