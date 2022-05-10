import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/screens/office_map/cubit/office_map_bloc.dart';
import 'package:office_places/theme/theme.dart';

class OfficeMapPage extends StatelessWidget {
  const OfficeMapPage({Key? key}) : super(key: key);

  static Route route(int officeId) {
    return MaterialPageRoute<void>(
        builder: (_) => Builder(builder: (context) {
              final repository = context.read<Repository>();

              return BlocProvider(
                create: (_) => OfficeMapCubit(
                    repository: repository,
                    appBloc: context.read<AppBloc>(),
                    theme: Theme.of(context),
                    officeId: officeId),
                child: const OfficeMapPage(),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<OfficeMapCubit, OfficeMapState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }

      if (state.isSuccessAlertShown) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          showCupertinoDialog(
              barrierDismissible: true,
              useRootNavigator: true,
              context: context,
              builder: (ctx) {
                return CupertinoAlertDialog(
                  title: Text(
                    "Бронирование успешно",
                    style: theme.fonts.bodyM,
                  ),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      child: Text(
                        "Забронировать еще",
                        style: theme.fonts.bodyM
                            .copyWith(color: theme.colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        context.read<OfficeMapCubit>().updateOfficeMap();
                      },
                      isDefaultAction: true,
                    ),
                    CupertinoDialogAction(
                      child: Text(
                        "Завершить",
                        style: theme.fonts.bodyM
                            .copyWith(color: theme.colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        context.read<OfficeMapCubit>().updateOfficeMap();
                        context
                            .read<AppBloc>()
                            .add(const CurrentTabChanged(newTabIndex: 1));
                      },
                      isDefaultAction: true,
                    ),
                  ],
                );
              });
        });
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colors.white,
            ),
            onPressed: () {
              context.read<OfficeMapCubit>().returnToOfficesList(context);
            },
          ),
          title: Text(state.office!.name),
        ),
        body: Stack(children: [
          Align(
            child: GestureDetector(
              onTapDown: (details) =>
                  context.read<OfficeMapCubit>().placeSelected(details),
              child: CustomPaint(
                painter: _OfficeMapPainter(state.drawable!),
                child: const SizedBox(
                  width: 170,
                  height: 230,
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 30,
            height: 50,
            child: ConfirmSelectionButton(
              selectedPlaceId: state.selectedPlaceId,
            ),
          )
        ]),
      );
    });
  }
}

class ConfirmSelectionButton extends StatelessWidget {
  final int selectedPlaceId;

  const ConfirmSelectionButton({Key? key, required this.selectedPlaceId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: selectedPlaceId == -1
          ? null
          : () {
              context.read<OfficeMapCubit>().placeSelectionConfirmed();
            },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                100,
              ),
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(selectedPlaceId == -1
            ? theme.colors.black.withOpacity(0.6)
            : theme.colors.black),
      ),
      child: Text(
          selectedPlaceId == -1 ? "Укажите место на карте" : "Продолжить",
          style: theme.fonts.bodyL.copyWith(color: theme.colors.white)),
    );
  }
}

class _OfficeMapPainter extends CustomPainter {
  final DrawableRoot drawable;

  _OfficeMapPainter(this.drawable);

  @override
  void paint(Canvas canvas, Size size) {
    drawable.draw(
      canvas,
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
