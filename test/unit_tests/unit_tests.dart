import 'dart:convert' as json;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:office_places/models/office.dart';
import 'package:office_places/repository/office_api.dart';

void main() {
  group(
    'Тесты разбора jsonа с данными об офисе',
    () {
      test(
          'Проверяем объект из jsonа из ассетов и объект из метода getOfficeDetails',
          () async {
        TestWidgetsFlutterBinding.ensureInitialized();
        final data = await rootBundle.loadString('assets/data/office.json');
        final expected =
            Office.fromJson(json.jsonDecode(data) as Map<String, dynamic>);

        final officeApi = OfficeApi();

        final actual = await officeApi.getOfficeDetails(1);

        expect(
          actual.name == expected.name &&
              actual.id == expected.id &&
              actual.places.toSet().difference(expected.places.toSet()).isEmpty,
          true,
        );
      });
    },
  );
}
