import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:libra/feature/app/cubit/locale_cubit.dart';
import 'package:libra/feature/app/widget/libra_app.dart';

void main() {
  testWidgets('LibraApp показывает главную на кыргызском и русском', (
    tester,
  ) async {
    final localeCubit = LocaleCubit();
    addTearDown(localeCubit.close);

    await tester.pumpWidget(
      BlocProvider<LocaleCubit>.value(
        value: localeCubit,
        child: const LibraApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Башкы бет'), findsOneWidget);

    localeCubit.toggle();
    await tester.pumpAndSettle();
    expect(find.text('Главная'), findsOneWidget);
  });
}
