import 'dart:io';

import 'package:office_places/models/booking_result.dart';
import 'package:office_places/repository/response_result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBManager {
  DBManager._();

  static final DBManager db = DBManager._();

  static const bookingsHistoryTableName = "bookings";

  static Database? _database;
  final String _databaseName = "bookings.db";

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
    }

    try {
      _database = await openDatabase(
        path,
        readOnly: false,
        version: 1,
        onCreate: (db, version) async {
          try {
            await db.execute("CREATE TABLE $bookingsHistoryTableName ("
                "id INTEGER PRIMARY KEY, "
                "office_name TEXT NOT NULL, "
                "place_id INTEGER NOT NULL, "
                "booking_date INTEGER NOT NULL )");
          } catch (e) {
            print("Exception - $e");
          }
        },
      );
    } catch (e) {
      print("Open error - $e");
    }

    return _database!;
  }

  Future<ResponseResult<bool>> saveBooking(
      {required String officeName,
      required int placeId,
      required int bookingDate}) async {
    Database db = await database;

    Map<String, dynamic> newBookingMap = {
      "office_name": officeName,
      "place_id": placeId,
      "booking_date": bookingDate
    };

    try {
      int res = await db.insert(bookingsHistoryTableName, newBookingMap);
      if (res == 0) {
        return Success(true);
      } else {
        return Success(false);
      }
    } on DatabaseException catch (e) {
      return DBError(e);
    }
  }

  Future<ResponseResult<List<BookingResult>>> getBookings() async {
    final db = await database;

    String bookingsQuery = 'SELECT * FROM $bookingsHistoryTableName ';
    try {
      var res = await db.rawQuery(bookingsQuery);

      List<BookingResult> bookings = res.isNotEmpty
          ? res.map((e) => BookingResult.fromJson(e)).toList()
          : [];

      return Success(bookings);
    } on DatabaseException catch (e) {
      return DBError(e);
    }
  }
}
