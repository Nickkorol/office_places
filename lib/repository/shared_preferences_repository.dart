part of 'repository.dart';

class SharedPreferencesRepository {
  late final SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set currentTabIndex(int index) => _prefs.setInt("currentTabIndex", index);

  int get currentTabIndex => _prefs.getInt("currentTabIndex") ?? 0;

  MyAppTheme? get appTheme {
    var str = _prefs.getString("theme");

    if (str == null) return null;

    return EnumToString.fromString(MyAppTheme.values, str);
  }

  set appTheme(MyAppTheme? v) {
    if (v != null) _prefs.setString('theme', EnumToString.convertToString(v));
  }
}
