import 'package:flutter/material.dart';

class NoMoviesCard extends StatelessWidget {
  final Text title;
  const NoMoviesCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: title,
        subtitle: _subTitle(),
        isThreeLine: false,
      ),
    );
  }

  Text _subTitle() => const Text('Pull to refresh');
}
