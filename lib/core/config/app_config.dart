abstract final class AppConfig {
  /// Адрес бэкенда. Передаётся через
  /// `--dart-define=BASE_URL=...` или `--dart-define-from-file=...`.
  static const baseUrl = String.fromEnvironment('BASE_URL');
}
