import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/theme/theme.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required Repository repository})
      : _repository = repository,
        super(AppState(
          currentTabIndex: repository.sharedPreferences.currentTabIndex,
          theme: repository.sharedPreferences.appTheme ?? MyAppTheme.light,
        )) {
    on<CurrentTabChanged>(_onCurrentTabChanged);
    on<AppThemeChanged>(_onAppThemeChanged);
  }

  final Repository _repository;

  void _onCurrentTabChanged(CurrentTabChanged event, Emitter<AppState> emit) {
    _repository.sharedPreferences.currentTabIndex = event.newTabIndex;
    emit(state.copyWith(currentTabIndex: event.newTabIndex));
  }

  void _onAppThemeChanged(AppThemeChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(theme: event.theme));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
