import 'dart:io';
import 'database_stok.dart';

/// Class Fitur: Menu Input Barang Baru
/// Menerapkan prinsip 1 Class = 1 File & Single Responsibility Principle (SRP)
/// Bertanggung jawab khusus untuk pendaftaran barang baru ke Database Lokal Gudang
class MenuInputBarang {
  final DatabaseStok _database;

  MenuInputBarang(this._database);

  /// Menjalankan menu interaktif input barang baru
  void jalankan() {
    bool lanjutInput = true;

    while (lanjutInput) {
      print("\n${"=" * 60}");
      print(" MENU INPUT BARANG BARU (DATABASE GUDANG)");
      print("=" * 60);

      // 1. Tampilkan daftar barang yang sudah ada saat ini
      _tampilkanDaftarBarangSaatIni();

      print("\n--- FORMULIR INPUT BARANG BARU ---");
      print("Silakan masukkan informasi barang yang ingin didaftarkan:\n");

      // 2. Input Nama Barang
      String? nama;
      while (true) {
        stdout.write("1. Nama Barang Baru : ");
        nama = stdin.readLineSync()?.trim();

        if (nama == null || nama.isEmpty) {
          print("   [!] Nama barang tidak boleh kosong! Silakan masukkan nama barang.");
          continue;
        }

        // Cek apakah barang dengan nama tersebut sudah pernah didaftarkan
        if (_database.cekBarangAda(nama)) {
          print("   [!] Peringatan: Barang '$nama' sudah terdaftar di database!");
          stdout.write("   Apakah Anda tetap ingin mendaftarkannya sebagai entri baru? [y/n]: ");
          final konfirmasiDuplikat = stdin.readLineSync()?.trim().toLowerCase();
          if (konfirmasiDuplikat != 'y') {
            print("   Pendaftaran dibatalkan untuk nama tersebut.");
            continue;
          }
        }
        break;
      }

      // 3. Input Satuan Barang
      String? satuan;
      while (true) {
        stdout.write("2. Satuan Barang (contoh: pcs, kg, karung, pouch, box, unit) : ");
        satuan = stdin.readLineSync()?.trim();

        if (satuan == null || satuan.isEmpty) {
          print("   [!] Satuan barang tidak boleh kosong!");
          continue;
        }
        break;
      }

      // 4. Input Stok Awal
      double? stokAwal;
      while (true) {
        stdout.write("3. Stok Awal Barang : ");
        final inputStok = stdin.readLineSync()?.trim();
        stokAwal = double.tryParse(inputStok ?? "");

        if (stokAwal == null) {
          print("   [!] Stok awal harus berupa angka numerik (contoh: 10 atau 15.5)!");
          continue;
        }

        if (stokAwal < 0) {
          print("   [!] Stok awal tidak boleh bernilai negatif!");
          continue;
        }
        break;
      }

      // 5. Konfirmasi Ringkasan Data Sebelum Simpan
      print("\n${"-" * 60}");
      print(" RINGKASAN DATA BARANG BARU YANG AKAN DISIMPAN:");
      print(" - Nama Barang : $nama");
      print(" - Satuan      : $satuan");
      print(" - Stok Awal   : $stokAwal $satuan");
      print("-" * 60);

      stdout.write("Apakah data di atas sudah benar dan ingin disimpan? [y/n]: ");
      final simpan = stdin.readLineSync()?.trim().toLowerCase();

      if (simpan == 'y') {
        try {
          final barangBaru = _database.tambahBarangBaru(
            nama: nama,
            stokAwal: stokAwal,
            satuan: satuan,
          );

          print("\n[✓] BERHASIL! Barang baru telah didaftarkan ke Database Lokal.");
          print("    ID Barang : ${barangBaru.id}");
          print("    Nama      : ${barangBaru.nama}");
          print("    Stok      : ${barangBaru.stok} ${barangBaru.satuan}");
        } catch (e) {
          print("\n[!] Gagal menyimpan barang baru: $e");
        }
      } else {
        print("\n[i] Pendaftaran barang baru dibatalkan.");
      }

      // 6. Tanya apakah ingin menambah barang baru lagi
      stdout.write("\nApakah ingin menginput barang baru lainnya? [y/n]: ");
      final jawabLagi = stdin.readLineSync()?.trim().toLowerCase();
      if (jawabLagi != 'y') {
        lanjutInput = false;
      }
    }
  }

  /// Menampilkan ringkasan barang yang saat ini sudah ada di database
  void _tampilkanDaftarBarangSaatIni() {
    final listBarang = _database.semuaBarang;
    print("\n--- DAFTAR BARANG YANG SUDAH TERDAFTAR (${listBarang.length} item) ---");
    if (listBarang.isEmpty) {
      print("Belum ada data barang di database.");
      return;
    }

    for (var b in listBarang) {
      print("[ID: ${b.id.toString().padLeft(2)}] ${b.nama.padRight(28)} | Stok: ${b.stok} ${b.satuan}");
    }
  }
}
