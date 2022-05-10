import 'package:enum_to_string/enum_to_string.dart';
import 'package:office_places/repository/office_api.dart';
import 'package:office_places/repository/services/booking_service.dart';
import 'package:office_places/repository/services/db_service.dart';
import 'package:office_places/theme/theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_repository.dart';

class Repository {
  late final SharedPreferencesRepository sharedPreferences;
  late final OfficeApi officeApi;
  late final BookingService bookingService;
  late final DBManager dbService;

  init() async {
    sharedPreferences = SharedPreferencesRepository();
    officeApi = OfficeApi();
    bookingService = BookingService();
    dbService = DBManager.db;

    await sharedPreferences.init();
  }
}
