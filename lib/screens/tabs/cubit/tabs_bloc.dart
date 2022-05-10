import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/repository/repository.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  final Repository repository;
  final AppBloc appBloc;

  TabsCubit({required this.repository, required this.appBloc})
      : super(TabsState());
}
