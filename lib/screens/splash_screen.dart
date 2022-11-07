import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:recora/screens/list_screen.dart';
import 'package:recora/utilities/cubit/ltwm_cubit.dart';
import 'package:recora/utilities/themes.dart';
import 'package:recora/widgets/beating_heart.dart';

class SplashScreen extends StatelessWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LtwmCubitAbstract cubit = Modular.get<LtwmCubitAbstract>();
    return MaterialApp(
      theme: darkTheme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const BeatingHeart(height: beatingHeartHeight),
              _title1(),
              _title2(),
              _title3(),
              const Spacer(),
              const Spacer(),
              _attribute1(),
              _attribute2(),
              BlocBuilder<LtwmCubitAbstract, LtwmState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is LtwmInitial) cubit.showList();
                  if (state is LtwmShowList) Modular.to.pushReplacementNamed(ListScreen.route);
                  return const Spacer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _title1() => Text(
        'Love',
        style: darkTheme.textTheme.headline1,
      );

  Text _title2() => Text(
        'To Watch',
        style: darkTheme.textTheme.headline2,
      );

  Text _title3() => Text(
        'MOVIES!',
        style: darkTheme.textTheme.headline1,
      );

  Text _attribute1() => const Text('Powered By');
  Text _attribute2() => const Text('The Movie DB');
}
