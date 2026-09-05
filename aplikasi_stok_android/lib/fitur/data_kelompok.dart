import '../models/anggota.dart';

/// Class Fitur: Menu Data Kelompok
/// Sesuai Kriteria Tugas: Data kelompok
class MenuDataKelompok {
  /// Menampilkan data kelompok pengembang
  void tampilkan() {
    print("\n${"=" * 60}");
    print(" DATA KELOMPOK MAHASISWA");
    print("=" * 60);
    print("Mata Kuliah : Pemrograman Mobile");
    print("Tugas       : Tugas 2 - Pemrograman Berorientasi Objek (OOP Dart)\n");

    final daftar = AnggotaKelompok.ambilDaftarAnggota();

    for (int i = 0; i < daftar.length; i++) {
      final mhs = daftar[i];
      print("${i + 1}. Nama  : ${mhs.nama}");
      print("   NIM   : ${mhs.nim}");
      if (mhs.peran.trim().isNotEmpty) {
        print("   Peran : ${mhs.peran}");
      }
      print("   ---------------------------------------------------------");
    }
  }
}
