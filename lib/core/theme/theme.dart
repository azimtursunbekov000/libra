import 'package:flutter/material.dart';

import 'my_color.dart';
import 'sf_pro.dart';

ThemeData buildLightTheme() {
  final color = MyColor.light();

  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: color.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color.brand)),
    ),
    extensions: [
      color,
      SfPro.light(myColor: color),
    ],
  );
}
