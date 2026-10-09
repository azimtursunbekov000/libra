// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_color.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$MyColorTailorMixin on ThemeExtension<MyColor> {
  Color get brand;
  Color get red;
  Color get blue;
  Color get grey;
  Color get white;
  Color get black;
  Color get ghostWhite;

  @override
  MyColor copyWith({
    Color? brand,
    Color? red,
    Color? blue,
    Color? grey,
    Color? white,
    Color? black,
    Color? ghostWhite,
  }) {
    return MyColor(
      brand: brand ?? this.brand,
      red: red ?? this.red,
      blue: blue ?? this.blue,
      grey: grey ?? this.grey,
      white: white ?? this.white,
      black: black ?? this.black,
      ghostWhite: ghostWhite ?? this.ghostWhite,
    );
  }

  @override
  MyColor lerp(covariant ThemeExtension<MyColor>? other, double t) {
    if (other is! MyColor) return this as MyColor;
    return MyColor(
      brand: Color.lerp(brand, other.brand, t)!,
      red: Color.lerp(red, other.red, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      ghostWhite: Color.lerp(ghostWhite, other.ghostWhite, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyColor &&
            const DeepCollectionEquality().equals(brand, other.brand) &&
            const DeepCollectionEquality().equals(red, other.red) &&
            const DeepCollectionEquality().equals(blue, other.blue) &&
            const DeepCollectionEquality().equals(grey, other.grey) &&
            const DeepCollectionEquality().equals(white, other.white) &&
            const DeepCollectionEquality().equals(black, other.black) &&
            const DeepCollectionEquality().equals(
              ghostWhite,
              other.ghostWhite,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(brand),
      const DeepCollectionEquality().hash(red),
      const DeepCollectionEquality().hash(blue),
      const DeepCollectionEquality().hash(grey),
      const DeepCollectionEquality().hash(white),
      const DeepCollectionEquality().hash(black),
      const DeepCollectionEquality().hash(ghostWhite),
    );
  }
}

extension MyColorBuildContextProps on BuildContext {
  MyColor get myColor => Theme.of(this).extension<MyColor>()!;
  Color get brand => myColor.brand;
  Color get red => myColor.red;
  Color get blue => myColor.blue;
  Color get grey => myColor.grey;
  Color get white => myColor.white;
  Color get black => myColor.black;
  Color get ghostWhite => myColor.ghostWhite;
}
