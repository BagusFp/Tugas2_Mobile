import 'dart:io';
import '../models/user.dart';

/// Class Fitur: Menu Login (Username & Password)
/// Sesuai Kriteria Tugas: Memiliki menu login (username dan password)
class MenuLogin {
  final List<User> _daftarUser = [
    User(username: "admin", password: "admin123"),
    User(username: "user", password: "user123"),
  ];

  User? _userAktif;

  /// Memeriksa apakah user sudah login
  bool get isSudahLogin => _userAktif != null;

  /// User yang sedang login saat ini
  User? get userAktif => _userAktif;

  /// Menjalankan prompt login interaktif di terminal
  bool jalankan() {
    int kesempatan = 3;

    while (kesempatan > 0) {
      print("\n${"=" * 60}");
      print(" MENU LOGIN SISTEM");
      print("=" * 60);
      print("Petunjuk Demo -> Username: 'admin' | Password: 'admin123'");
      print("Sisa kesempatan percobaan: $kesempatan\n");

      stdout.write("Masukkan Username : ");
      String username = stdin.readLineSync()?.trim() ?? "";
      stdout.write("Masukkan Password : ");
      String password = stdin.readLineSync()?.trim() ?? "";

      if (username.isEmpty || password.isEmpty) {
        print("\n[!] Username dan password wajib diisi!");
        kesempatan--;
        continue;
      }

      for (var u in _daftarUser) {
        if (u.username.toLowerCase() == username.toLowerCase() &&
            u.verifikasiPassword(password)) {
          _userAktif = u;
          print("\n[✓] LOGIN BERHASIL! Selamat datang, ${_userAktif!.username}.");
          return true;
        }
      }

      kesempatan--;
      print("\n[X] Username atau password salah!");
    }

    print("\n[!] Batas percobaan login terlampaui.");
    return false;
  }

  /// Logout dari sesi saat ini
  void logout() {
    _userAktif = null;
  }
}
