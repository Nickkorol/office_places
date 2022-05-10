part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppThemeChanged extends AppEvent {
  final MyAppTheme theme;

  const AppThemeChanged({required this.theme});
}

class CurrentTabChanged extends AppEvent {
  final int newTabIndex;

  const CurrentTabChanged({required this.newTabIndex});
}
