part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final bool isLoading;
  final List<BookingResult> bookingsList;
  final String? errorText;

  const HistoryState(
      {required this.bookingsList, this.isLoading = true, this.errorText});

  HistoryState copyWith(
      {List<BookingResult>? bookingsList, bool? isLoading, String? errorText}) {
    return HistoryState(
        bookingsList: bookingsList ?? this.bookingsList,
        isLoading: isLoading ?? this.isLoading,
        errorText: errorText ?? this.errorText);
  }

  @override
  List<Object?> get props => [bookingsList, isLoading, errorText];
}
