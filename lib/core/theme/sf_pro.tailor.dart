// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sf_pro.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SfProTailorMixin on ThemeExtension<SfPro> {
  TextStyle get s24W500;
  TextStyle get s18W600;
  TextStyle get s16W500;
  TextStyle get s16W400;
  TextStyle get s14W500;
  TextStyle get s12W400;
  TextStyle get s10W400;

  @override
  SfPro copyWith({
    TextStyle? s24W500,
    TextStyle? s18W600,
    TextStyle? s16W500,
    TextStyle? s16W400,
    TextStyle? s14W500,
    TextStyle? s12W400,
    TextStyle? s10W400,
  }) {
    return SfPro(
      s24W500: s24W500 ?? this.s24W500,
      s18W600: s18W600 ?? this.s18W600,
      s16W500: s16W500 ?? this.s16W500,
      s16W400: s16W400 ?? this.s16W400,
      s14W500: s14W500 ?? this.s14W500,
      s12W400: s12W400 ?? this.s12W400,
      s10W400: s10W400 ?? this.s10W400,
    );
  }

  @override
  SfPro lerp(covariant ThemeExtension<SfPro>? other, double t) {
    if (other is! SfPro) return this as SfPro;
    return SfPro(
      s24W500: TextStyle.lerp(s24W500, other.s24W500, t)!,
      s18W600: TextStyle.lerp(s18W600, other.s18W600, t)!,
      s16W500: TextStyle.lerp(s16W500, other.s16W500, t)!,
      s16W400: TextStyle.lerp(s16W400, other.s16W400, t)!,
      s14W500: TextStyle.lerp(s14W500, other.s14W500, t)!,
      s12W400: TextStyle.lerp(s12W400, other.s12W400, t)!,
      s10W400: TextStyle.lerp(s10W400, other.s10W400, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SfPro &&
            const DeepCollectionEquality().equals(s24W500, other.s24W500) &&
            const DeepCollectionEquality().equals(s18W600, other.s18W600) &&
            const DeepCollectionEquality().equals(s16W500, other.s16W500) &&
            const DeepCollectionEquality().equals(s16W400, other.s16W400) &&
            const DeepCollectionEquality().equals(s14W500, other.s14W500) &&
            const DeepCollectionEquality().equals(s12W400, other.s12W400) &&
            const DeepCollectionEquality().equals(s10W400, other.s10W400));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(s24W500),
      const DeepCollectionEquality().hash(s18W600),
      const DeepCollectionEquality().hash(s16W500),
      const DeepCollectionEquality().hash(s16W400),
      const DeepCollectionEquality().hash(s14W500),
      const DeepCollectionEquality().hash(s12W400),
      const DeepCollectionEquality().hash(s10W400),
    );
  }
}

extension SfProBuildContextProps on BuildContext {
  SfPro get sfPro => Theme.of(this).extension<SfPro>()!;
  TextStyle get s24W500 => sfPro.s24W500;
  TextStyle get s18W600 => sfPro.s18W600;
  TextStyle get s16W500 => sfPro.s16W500;
  TextStyle get s16W400 => sfPro.s16W400;
  TextStyle get s14W500 => sfPro.s14W500;
  TextStyle get s12W400 => sfPro.s12W400;
  TextStyle get s10W400 => sfPro.s10W400;
}
