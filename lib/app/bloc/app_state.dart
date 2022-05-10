part of 'app_bloc.dart';

class AppState extends Equatable {
  final int currentTabIndex;
  final MyAppTheme theme;

  const AppState({required this.currentTabIndex, required this.theme});

  AppState copyWith({int? currentTabIndex, MyAppTheme? theme}) {
    return AppState(
        currentTabIndex: currentTabIndex ?? this.currentTabIndex,
        theme: theme ?? this.theme);
  }

  @override
  List<Object> get props => [currentTabIndex, theme];
}
