abstract interface class TokenStorage {
  Future<String?> read();
  Future<void> write(String value);
  Future<void> delete();
}
