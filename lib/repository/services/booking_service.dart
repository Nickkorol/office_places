import 'dart:async';

import 'package:office_places/models/booking_result.dart';
import 'package:office_places/repository/response_result.dart';
import 'package:office_places/repository/services/db_service.dart';

class BookingService {
  final DBManager _provider = DBManager.db;

  final _controller = StreamController<List<BookingResult>>.broadcast();

  Stream<List<BookingResult>> get bookingsStream => _controller.stream;

  Future<ResponseResult<bool>> book({
    required int placeId,
    required String officeName,
  }) async {
    final bookings = await getBookings();

    if (bookings is Success) {
      final successfulBookings = (bookings as Success).data;

      final lastId = successfulBookings.isEmpty
          ? -1
          : successfulBookings.reversed.first.id;

      final newBookingsList = successfulBookings.reversed.toList()
        ..add(BookingResult(
            id: lastId + 1,
            officeName: officeName,
            placeId: placeId,
            bookingDate: DateTime.now().millisecondsSinceEpoch));
      _controller.add(newBookingsList);
    }

    return _provider.saveBooking(
        officeName: officeName,
        placeId: placeId,
        bookingDate: DateTime.now().millisecondsSinceEpoch);
  }

  Future<ResponseResult<List<BookingResult>>> getBookings() =>
      _provider.getBookings();
}
