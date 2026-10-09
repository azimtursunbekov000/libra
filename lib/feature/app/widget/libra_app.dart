import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libra/core/theme/theme.dart';
import 'package:libra/core/util/app_navigator.dart';
import 'package:libra/feature/app/cubit/locale_cubit.dart';
import 'package:libra/feature/home/widget/page/home_page.dart';
import 'package:libra/l10n/app_localizations.dart';

class LibraApp extends StatelessWidget {
  const LibraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          navigatorKey: appNavigatorKey,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          theme: buildLightTheme(),
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomePage(),
          builder: (context, child) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: child ?? const SizedBox(),
            );
          },
        );
      },
    );
  }
}
