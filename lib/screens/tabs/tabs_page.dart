import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/screens/history/history_page.dart';
import 'package:office_places/screens/offices_list/offices_list_page.dart';
import 'package:office_places/screens/tabs/cubit/tabs_bloc.dart';
import 'package:office_places/theme/theme.dart';

class TabsPage extends StatelessWidget {
  TabsPage({Key? key}) : super(key: key);

  static Route route(RouteSettings settings) {
    return MaterialPageRoute<void>(
        builder: (_) => Builder(builder: (context) {
              final repository = context.read<Repository>();

              return BlocProvider(
                create: (_) => TabsCubit(
                    repository: repository, appBloc: context.read<AppBloc>()),
                child: TabsPage(),
              );
            }),
        settings: settings);
  }

  final _kTabPages = [OfficesListPage.builder(), HistoryPage.builder()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return Scaffold(
        body: IndexedStack(
          index: appState.currentTabIndex,
          children: _kTabPages,
        ),
        bottomNavigationBar: SizedBox(
            height: 82,
            child: Row(
              children: [
                _BottomBarIcon(
                    isActive: appState.currentTabIndex == 0,
                    onTap: () => context
                        .read<AppBloc>()
                        .add(const CurrentTabChanged(newTabIndex: 0)),
                    assetPath: "assets/svg/ic_home.svg"),
                _BottomBarIcon(
                  isActive: appState.currentTabIndex == 1,
                  onTap: () => context
                      .read<AppBloc>()
                      .add(const CurrentTabChanged(newTabIndex: 1)),
                  assetPath: "assets/svg/ic_history.svg",
                ),
              ],
            )),
      );
    });
  }
}

class _BottomBarIcon extends StatelessWidget {
  const _BottomBarIcon(
      {Key? key,
      required this.isActive,
      required this.assetPath,
      required this.onTap})
      : super(key: key);
  final bool isActive;
  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
        child: Column(
      children: [
        isActive
            ? Container(
                height: 3,
                decoration: BoxDecoration(
                  color: theme.colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(0.5)),
                ),
              )
            : const SizedBox(),
        Expanded(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: SvgPicture.asset(assetPath),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
