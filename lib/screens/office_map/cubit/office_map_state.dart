part of 'office_map_bloc.dart';

class OfficeMapState extends Equatable {
  final Office? office;
  final bool isLoading;
  final int selectedPlaceId;
  final DrawableRoot? drawable;
  final bool isSuccessAlertShown;

  const OfficeMapState(
      {this.office,
      required this.isLoading,
      this.selectedPlaceId = -1,
      this.drawable,
      this.isSuccessAlertShown = false});
  OfficeMapState copyWith(
      {Office? office,
      bool? isLoading,
      int? selectedPlaceId,
      DrawableRoot? drawable,
      bool? isSuccessAlertShown}) {
    return OfficeMapState(
        office: office ?? this.office,
        isLoading: isLoading ?? this.isLoading,
        selectedPlaceId: selectedPlaceId ?? this.selectedPlaceId,
        drawable: drawable ?? this.drawable,
        isSuccessAlertShown: isSuccessAlertShown ?? this.isSuccessAlertShown);
  }

  @override
  List<Object?> get props =>
      [office, isLoading, selectedPlaceId, drawable, isSuccessAlertShown];
}
