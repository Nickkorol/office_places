import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/models/office.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/screens/offices_list/cubit/offices_list_bloc.dart';
import 'package:office_places/theme/theme.dart';

class OfficesListPage extends StatelessWidget {
  const OfficesListPage({Key? key}) : super(key: key);

  static Widget builder() {
    return Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => Builder(builder: (context) {
                  final repository = context.read<Repository>();

                  return BlocProvider(
                    lazy: false,
                    create: (_) {
                      return OfficesListCubit(
                          repository: repository,
                          appBloc: context.read<AppBloc>());
                    },
                    child: const OfficesListPage(),
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficesListCubit, OfficesListState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Бронирование места в офисе"),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          itemBuilder: (context, index) {
            return _OfficeListWidget(
              office: state.offices[index],
              onTap: (office) {
                context
                    .read<OfficesListCubit>()
                    .openOfficeMap(state.offices[index].id, context);
              },
            );
          },
          itemCount: state.offices.length,
        ),
      );
    });
  }
}

class _OfficeListWidget extends StatelessWidget {
  final Office office;
  final void Function(Office) onTap;

  const _OfficeListWidget({
    Key? key,
    required this.office,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.colors.black.withOpacity(0.2),
            blurRadius: 10,
          )
        ],
        color: theme.colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onTap(office),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              office.name,
              style: theme.fonts.bodyL,
            ),
          ),
        ),
      ),
    );
  }
}
