import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/models/booking_result.dart';
import 'package:office_places/models/office.dart';
import 'package:office_places/models/office_place.dart';
import 'package:office_places/repository/response_result.dart';
import 'package:office_places/repository/services/office_drawer_service.dart';
import 'package:office_places/repository/repository.dart';

part 'office_map_state.dart';

class OfficeMapCubit extends Cubit<OfficeMapState> {
  final Repository repository;
  final AppBloc appBloc;
  final int officeId;
  final ThemeData theme;
  late OfficeDrawerService structureService;

  OfficeMapCubit(
      {required this.repository,
      required this.appBloc,
      required this.officeId,
      required this.theme})
      : super(const OfficeMapState(isLoading: true)) {
    getOfficeData(theme);
  }

  void getOfficeData(ThemeData theme) async {
    final officeData = await repository.officeApi.getOfficeDetails(officeId);
    final officeStructureBytes = await getOfficeStructure();
    final drawable = await svg.fromSvgBytes(
      officeStructureBytes,
      'structure',
    );
    final bookingsResult = await repository.bookingService.getBookings();
    List<int> bookedPlacesIds = [];
    if (bookingsResult is Success) {
      final bookings = (bookingsResult as Success).data as List<BookingResult>;
      bookedPlacesIds = bookings.map((booking) => booking.placeId).toList();
    }
    structureService = OfficeDrawerService(drawable: drawable, theme: theme);
    structureService.drawMap(
        places: officeData.places, bookedPlacesIds: bookedPlacesIds);
    emit(state.copyWith(
        office: officeData,
        isLoading: false,
        drawable: structureService.drawable));
  }

  Future<Uint8List> getOfficeStructure() async {
    final byteData = await rootBundle.load("assets/data/structure.svg");

    return byteData.buffer.asUint8List();
  }

  void returnToOfficesList(BuildContext context) {
    Navigator.pop(context);
  }

  void placeSelectionConfirmed() async {
    repository.bookingService
        .book(placeId: state.selectedPlaceId, officeName: state.office!.name);

    emit(state.copyWith(isSuccessAlertShown: true));
  }

  void placeSelected(TapDownDetails details) {
    final offset = details.localPosition;

    var selectedPlaceId = -1;

    for (var shape in state.drawable!.children) {
      final path = shape as DrawableShape;

      if ((path.id != null && path.id!.isNotEmpty) &&
          path.bounds.contains(offset)) {
        selectedPlaceId = int.tryParse(path.id!) ?? -1;
      }
    }

    if (selectedPlaceId == -1) {
      emit(state.copyWith(selectedPlaceId: selectedPlaceId));
    }
    OfficePlace? newSelectedPlace;
    for (final place in state.office!.places) {
      if (place.id == selectedPlaceId && place.available) {
        place.chosen = true;
        newSelectedPlace = place;
      } else {
        place.chosen = false;
      }
    }
    if (newSelectedPlace != null &&
        newSelectedPlace.id != state.selectedPlaceId) {
      emit(state.copyWith(selectedPlaceId: newSelectedPlace.id));
    }

    structureService.drawMap(places: state.office!.places);
  }

  void updateOfficeMap() {
    for (var place in state.office!.places) {
      if (place.id == state.selectedPlaceId) {
        place.available = false;
      }
      place.chosen = false;
    }
    structureService.drawMap(places: state.office!.places);

    emit(state.copyWith(isSuccessAlertShown: false, selectedPlaceId: -1));
  }
}
