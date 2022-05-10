import 'dart:convert' as json;

import 'package:flutter/services.dart';
import 'package:office_places/models/office.dart';

class OfficeApi {
  Future<List<Office>> getOffices() async {
    final data = await rootBundle.loadString('assets/data/office.json');
    final office =
        Office.fromJson(json.jsonDecode(data) as Map<String, dynamic>);

    return [office];
  }

  Future<Office> getOfficeDetails(int id) async {
    final offices = await getOffices();

    return offices.where((element) => element.id == id).first;
  }
}
