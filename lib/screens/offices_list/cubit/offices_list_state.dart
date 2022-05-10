part of 'offices_list_bloc.dart';

class OfficesListState extends Equatable {
  final List<Office> offices;

  const OfficesListState({required this.offices});
  OfficesListState copyWith({List<Office>? offices}) {
    return OfficesListState(offices: offices ?? this.offices);
  }

  @override
  List<Object?> get props => [offices];
}
