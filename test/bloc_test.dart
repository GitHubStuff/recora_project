import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recora/utilities/cubit/ltwm_cubit.dart';

class MockLTWMCubit extends MockCubit<LtwmState> implements LtwmCubit, CubitAbstract {}

void main() {
  group(
    'BLOC Tests',
    () {
      blocTest(
        'Setup',
        build: () => LtwmCubit(),
        expect: () => [],
      );

      blocTest<LtwmCubit, LtwmState>(
        'Show List',
        build: () => LtwmCubit(),
        act: (bloc) => bloc.showList(),
        wait: const Duration(milliseconds: 300),
        expect: () => [isA<LtwmShowList>()],
      );
    },
  );
}
