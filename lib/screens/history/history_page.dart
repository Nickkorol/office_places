import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/formatters/date_formatter.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/screens/history/cubit/history_bloc.dart';
import 'package:office_places/theme/theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  static Widget builder() {
    return Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => Builder(builder: (context) {
                  final repository = context.read<Repository>();

                  return BlocProvider(
                    create: (_) => HistoryCubit(
                        repository: repository,
                        appBloc: context.read<AppBloc>()),
                    child: const HistoryPage(),
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История бронирований"),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 15),
        child: _BookingsHistoryListWidget(),
      ),
    );
  }
}

class _BookingsHistoryListWidget extends StatelessWidget {
  const _BookingsHistoryListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HistoryCubit, HistoryState>(builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.errorText != null) {
        return Center(
          child:
              Text("Упс! Произошла ошибка. Текст ошибки - ${state.errorText}"),
        );
      }
      if (state.bookingsList.isEmpty) {
        return const Center(child: Text("Список бронирований пуст"));
      }

      return ListView.builder(
        itemBuilder: ((context, index) {
          final booking = state.bookingsList[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Container(
              height: 160,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.colors.black.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
                color: theme.colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colors.blue,
                        radius: 15,
                        child: SvgPicture.asset(
                          "assets/svg/ic_refresh.svg",
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "#${booking.id}",
                        style: theme.fonts.bodyL,
                      ),
                      const Spacer(flex: 1),
                      Text(
                        historyFormattedDate(booking.bookingDate),
                        style: theme.fonts.bodyM,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    booking.officeName,
                    style: theme.fonts.bodyM,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Место: ${booking.placeId}',
                    style: theme.fonts.bodyM,
                  ),
                ],
              ),
            ),
          );
        }),
        itemCount: state.bookingsList.length,
      );
    });
  }
}
