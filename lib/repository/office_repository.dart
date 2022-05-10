import 'package:office_places/models/office.dart';
import 'package:office_places/repository/office_api.dart';

class OfficeRepository {
  final OfficeApi _officeApi;

  OfficeRepository(this._officeApi);

  Future<List<Office>> getOffices() async {
    final data = await _officeApi.getOffices();

    return data;
  }

  Future<Office> getOfficeDetails(int id) async {
    final data = await _officeApi.getOfficeDetails(id);

    return data;
  }
}
