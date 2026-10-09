import 'package:flutter/material.dart';
import 'package:libra/core/theme/sf_pro.dart';
import 'package:libra/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sfPro = Theme.of(context).extension<SfPro>()!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle, style: sfPro.s18W600)),
    );
  }
}
