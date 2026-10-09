import 'package:libra/core/model/access.dart';
import 'package:libra/core/util/token_storage.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class AuthorizationRepository {
  Future<void> authorize(Access access);
  Future<void> unAuthorize();
  Future<void> initAuthSession();

  BehaviorSubject<Access?> get accessSubj;
}

final class AuthorizationRepositoryImpl implements AuthorizationRepository {
  AuthorizationRepositoryImpl({required this._tokenStorage});

  final TokenStorage _tokenStorage;

  final BehaviorSubject<Access?> _accessSubj = BehaviorSubject.seeded(null);

  @override
  BehaviorSubject<Access?> get accessSubj => _accessSubj;

  @override
  Future<void> authorize(Access access) async {
    try {
      await _tokenStorage.write(accessToJson(access));
    } catch (_) {
      // Хранилище может быть недоступно (например, web на HTTP без SubtleCrypto).
      // Продолжаем сессию в памяти — пользователь авторизован до перезагрузки.
    }
    _accessSubj.add(access);
  }

  @override
  Future<void> unAuthorize() async {
    try {
      await _tokenStorage.delete();
    } catch (_) {}
    _accessSubj.add(null);
  }

  @override
  Future<void> initAuthSession() async {
    try {
      final access = await _tokenStorage.read();
      if (access != null) {
        _accessSubj.add(accessFromJson(access));
      }
    } catch (_) {
      try {
        await _tokenStorage.delete();
      } catch (_) {}
      _accessSubj.add(null);
    }
  }
}
