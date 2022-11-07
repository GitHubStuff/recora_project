import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/failure.dart';
import '../utilities/cubit/ltwm_cubit.dart';

class NetworkErrorCard extends StatelessWidget {
  final Failure failure;
  const NetworkErrorCard({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _networkError(reason: failure.message),
      subtitle: _subTitle(),
      isThreeLine: false,
      onTap: () {
        Modular.get<LtwmCubitAbstract>().downloadList();
      },
    );
  }

  Text _networkError({required String reason}) => Text('Network Error - $reason');
  Text _subTitle() => const Text('"TAP" to retry');
}
