import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recora/screens/detail_screen.dart';
import 'package:recora/screens/splash_screen.dart';
import 'package:recora/utilities/cubit/ltwm_cubit.dart';

import 'networking/network_request.dart';
import 'screens/list_screen.dart';

typedef Json = Map<String, dynamic>;

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => LtwmCubit()),
        Bind.singleton((i) => NetworkRequest(appId: '03bcaad16da8b43e65490745a4832412')),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreen()),
        ChildRoute(
          ListScreen.route,
          child: (_, __) => ListScreen(),
        ),
        ChildRoute(
          DetailScreen.route,
          child: (_, args) => DetailScreen(movie: args.data),
        )
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LTWM',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension   }}
  }
}
