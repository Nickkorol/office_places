import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_places/models/office_place.dart';
import 'package:office_places/theme/theme.dart';

class OfficeDrawerService {
  final DrawableRoot drawable;
  final ThemeData theme;

  OfficeDrawerService({required this.drawable, required this.theme});

  void drawMap(
      {required List<OfficePlace> places, List<int>? bookedPlacesIds}) {
    for (final d in drawable.children.toList()) {
      if (d.id != null && d.id!.isNotEmpty) {
        final place = places.firstWhere(
          (element) => element.id == int.parse(d.id!),
        );
        if (bookedPlacesIds != null &&
            bookedPlacesIds.indexWhere((id) => id == place.id) != -1) {
          place.available = false;
        }

        final newPath = (d as DrawableShape).mergeStyle(
          DrawableStyle(
            fill: DrawablePaint(
              PaintingStyle.fill,
              color: place.available
                  ? place.chosen
                      ? theme.colors.green
                      : theme.colors.blue
                  : theme.colors.mediumGray,
            ),
          ),
        );

        drawable.children.remove(d);
        drawable.children.add(newPath);
      }
    }
  }
}
