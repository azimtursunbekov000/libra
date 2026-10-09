import 'package:dio/dio.dart';
import 'package:libra/core/util/app_navigator.dart';
import 'package:libra/feature/auth/authorization/data/authorization_repository.dart';

final class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this._authorizationRepository});

  final AuthorizationRepository _authorizationRepository;

  /// Эндпоинты, доступные без авторизации. Для них токен не прикрепляется,
  /// чтобы протухший/чужой токен не приводил к ошибке на бэкенде.
  ///
  /// Allowlist: всё, что не перечислено здесь, получает токен.
  /// Пути без ведущего слеша, как в [RequestOptions.uri].
  static const Set<String> _publicPaths = {'auth/login', 'auth/register'};

  bool _isPublic(RequestOptions options) {
    final path = options.uri.path.replaceFirst(RegExp(r'^/+'), '');
    return _publicPaths.contains(path);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isPublic(options)) {
      options.headers.remove('Authorization');
      return handler.next(options);
    }

    final access = _authorizationRepository.accessSubj.valueOrNull;
    if (access != null && access.result.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${access.result}';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _authorizationRepository.unAuthorize();
      appNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    }

    return handler.next(err);
  }
}
