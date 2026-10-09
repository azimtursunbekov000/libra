import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'my_color.dart';

part 'sf_pro.tailor.dart';

@TailorMixin()
final class SfPro extends ThemeExtension<SfPro> with _$SfProTailorMixin {
  const SfPro({
    required this.s24W500,
    required this.s18W600,
    required this.s16W500,
    required this.s16W400,
    required this.s14W500,
    required this.s12W400,
    required this.s10W400,
  });

  @override
  final TextStyle s24W500;
  @override
  final TextStyle s18W600;
  @override
  final TextStyle s16W500;
  @override
  final TextStyle s16W400;
  @override
  final TextStyle s14W500;
  @override
  final TextStyle s12W400;
  @override
  final TextStyle s10W400;

  factory SfPro.light({required MyColor myColor}) {
    return SfPro(
      s24W500: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'SF Pro',
        letterSpacing: -0.41,
      ),
      s18W600: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'SF Pro',
        letterSpacing: -0.41,
      ),
      s16W500: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'SF Pro Display',
        letterSpacing: -0.41,
      ),
      s16W400: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Pro',
        color: myColor.black,
        letterSpacing: -0.41,
      ),
      s14W500: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'SF Pro',
        letterSpacing: -0.41,
      ),
      s12W400: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Pro',
        letterSpacing: -0.41,
      ),
      s10W400: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Pro',
        color: myColor.red,
        letterSpacing: -0.41,
      ),
    );
  }
}
