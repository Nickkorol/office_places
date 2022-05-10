import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/models/booking_result.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/repository/response_result.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final Repository repository;
  final AppBloc appBloc;

  late StreamSubscription<List<BookingResult>> _subscription;

  HistoryCubit({required this.repository, required this.appBloc})
      : super(const HistoryState(bookingsList: [])) {
    getBookings();
    _subscription =
        repository.bookingService.bookingsStream.listen(_updateBookingsHistory);
  }
  // void changeTheme(MyAppTheme theme) {
  //   appBloc.add(AppThemeChanged(theme: theme));
  // }

  void _updateBookingsHistory(List<BookingResult> bookingsList) {
    bookingsList
        .sort((booking1, booking2) => booking2.id.compareTo(booking1.id));
    emit(state.copyWith(bookingsList: bookingsList, isLoading: false));
  }

  void getBookings() async {
    final result = await repository.bookingService.getBookings();
    if (result is Success) {
      List<BookingResult> bookingsList = (result as Success).data;
      bookingsList
          .sort((booking1, booking2) => booking2.id.compareTo(booking1.id));
      emit(state.copyWith(bookingsList: bookingsList, isLoading: false));
    } else {
      emit(state.copyWith(
          errorText: (result as DBError).error.toString(), isLoading: false));
    }
  }
}
