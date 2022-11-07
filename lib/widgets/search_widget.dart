import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../utilities/cubit/ltwm_cubit.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidget();
}

class _SearchWidget extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (newString) {
        final LtwmCubitAbstract cubit = Modular.get<LtwmCubitAbstract>();
        cubit.searchRequest(newString);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
