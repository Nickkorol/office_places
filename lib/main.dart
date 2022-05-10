import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_places/app/bloc/app_bloc.dart';
import 'package:office_places/app/bloc_observer.dart';
import 'package:office_places/main_provider.dart';
import 'package:office_places/repository/repository.dart';
import 'package:office_places/screens/tabs/tabs_page.dart';
import 'package:office_places/theme/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  final repository = Repository();
  await repository.init();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required Repository repository})
      : _repository = repository,
        super(key: key);

  final Repository _repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _repository,
        child: ChangeNotifierProvider<MainProvider>(
          create: (_) => MainProvider(),
          builder: (context, snapshot) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<AppBloc>(
                  create: (BuildContext context) => AppBloc(
                    repository: _repository,
                  ),
                )
              ],
              child: Builder(builder: (BuildContext themeContext) {
                var theme =
                    themeContext.select((AppBloc bloc) => bloc.state.theme);
                return MaterialApp(
                    title: 'Office Map',
                    theme: MyAppThemeData(theme).themeData,
                    onGenerateRoute: (RouteSettings settings) {
                      return TabsPage.route(settings);
                    });
              }),
            );
          },
        ));
  }
}
