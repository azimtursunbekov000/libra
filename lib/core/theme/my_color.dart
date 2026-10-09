import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'my_color.tailor.dart';

@TailorMixin()
final class MyColor extends ThemeExtension<MyColor> with _$MyColorTailorMixin {
  const MyColor({
    required this.brand,
    required this.red,
    required this.blue,
    required this.grey,
    required this.white,
    required this.black,
    required this.ghostWhite,
  });

  @override
  final Color brand;
  @override
  final Color red;
  @override
  final Color blue;
  @override
  final Color grey;
  @override
  final Color white;
  @override
  final Color black;
  @override
  final Color ghostWhite;

  factory MyColor.light() {
    return const MyColor(
      brand: Color(0xff1565C0),
      red: Color(0xffD32F2F),
      blue: Color(0xff1565C0),
      grey: Color(0xffC2C2C2),
      white: Color(0xffFFFFFF),
      black: Color(0xff000000),
      ghostWhite: Color(0xffF6F8FB),
    );
  }
}
