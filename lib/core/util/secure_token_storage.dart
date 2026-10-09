import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:libra/core/constans/storage_key.dart';
import 'package:libra/core/util/token_storage.dart';

final class SecureTokenStorage implements TokenStorage {
  const SecureTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() => _storage.read(key: StorageKey.access);

  @override
  Future<void> write(String value) =>
      _storage.write(key: StorageKey.access, value: value);

  @override
  Future<void> delete() => _storage.delete(key: StorageKey.access);
}
