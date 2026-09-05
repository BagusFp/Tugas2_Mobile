/// Model class untuk merepresentasikan Pengguna Sistem
/// Menerapkan prinsip OOP: Encapsulation (penyembunyian data password)
class User {
  final String username;
  final String _password; // Private attribute

  User({
    required this.username,
    required String password,
  }) : _password = password;

  /// Memverifikasi kecocokan password yang diinputkan
  bool verifikasiPassword(String inputPassword) {
    return _password == inputPassword;
  }
}
