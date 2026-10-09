import 'package:libra/core/constans/storage_key.dart';
import 'package:libra/core/util/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class PrefsTokenStorage implements TokenStorage {
  const PrefsTokenStorage(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<String?> read() async => _prefs.getString(StorageKey.access);

  @override
  Future<void> write(String value) async {
    await _prefs.setString(StorageKey.access, value);
  }

  @override
  Future<void> delete() async {
    await _prefs.remove(StorageKey.access);
  }
}
