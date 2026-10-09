import 'package:flutter/material.dart';

abstract final class AppBreakpoints {
  /// Ширина экрана, ниже которой приложение переключается на мобильную вёрстку.
  static const double mobile = 600;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobile;
}
