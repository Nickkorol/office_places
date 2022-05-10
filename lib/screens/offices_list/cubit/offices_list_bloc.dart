import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/models/office.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/screens/office_map/office_map_page.dart';

part 'offices_list_state.dart';

class OfficesListCubit extends Cubit<OfficesListState> {
  final Repository repository;
  final AppBloc appBloc;

  OfficesListCubit({required this.repository, required this.appBloc})
      : super(const OfficesListState(offices: [])) {
    getOffices();
  }

  void getOffices() async {
    final result = await repository.officeApi.getOffices();
    emit(state.copyWith(offices: result));
  }

  void openOfficeMap(int officeId, BuildContext context) {
    Navigator.push(context, OfficeMapPage.route(officeId));
  }
}
