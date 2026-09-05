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
    bool kembali = false;

    while (!kembali) {
      print("\n${"=" * 60}");
      print(" MENU INPUT BARANG BARU (DATABASE GUDANG)");
      print("=" * 60);
      print("1. Daftarkan Barang Baru");
      print("2. Lihat Daftar Barang Gudang Saat Ini");
      print("0. Kembali ke Menu Utama");
      print("=" * 60);
      stdout.write("Pilih opsi [0-2]: ");
      String? opsi = stdin.readLineSync()?.trim();

      switch (opsi) {
        case '1':
          _formInputBarangBaru();
          break;
        case '2':
          _tampilkanDaftarBarangSaatIni();
          stdout.write("\nTekan [ENTER] untuk melanjutkan...");
          stdin.readLineSync();
          break;
        case '0':
        case 'k':
        case 'kembali':
          kembali = true;
          print("\n[i] Kembali ke Menu Utama.");
          break;
        default:
          print("\n[!] Opsi tidak valid! Silakan pilih 0, 1, atau 2.");
      }
    }
  }

  /// Formulir pendaftaran barang baru
  void _formInputBarangBaru() {
    print("\n--- FORMULIR INPUT BARANG BARU ---");
    print("Silakan masukkan informasi barang yang ingin didaftarkan.");
    print("(Ketik '0' atau 'batal' kapan saja untuk membatalkan)\n");

    // 1. Input Nama Barang
    String? nama;
    while (true) {
      stdout.write("1. Nama Barang Baru (ketik '0' untuk batal): ");
      nama = stdin.readLineSync()?.trim();

      if (nama == '0' ||
          nama?.toLowerCase() == 'k' ||
          nama?.toLowerCase() == 'batal' ||
          nama?.toLowerCase() == 'kembali') {
        print("\n[i] Penginputan barang baru dibatalkan.");
        return;
      }

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

    // 2. Input Satuan Barang
    String? satuan;
    while (true) {
      stdout.write("2. Satuan Barang (contoh: pcs, kg, karung, pouch, box, unit) [ketik 'batal' untuk batal]: ");
      satuan = stdin.readLineSync()?.trim();

      if (satuan == '0' ||
          satuan?.toLowerCase() == 'batal' ||
          satuan?.toLowerCase() == 'k' ||
          satuan?.toLowerCase() == 'kembali') {
        print("\n[i] Penginputan barang baru dibatalkan.");
        return;
      }

      if (satuan == null || satuan.isEmpty) {
        print("   [!] Satuan barang tidak boleh kosong!");
        continue;
      }
      break;
    }

    // 3. Input Stok Awal
    double? stokAwal;
    while (true) {
      stdout.write("3. Stok Awal Barang [ketik 'batal' untuk batal]: ");
      final inputStok = stdin.readLineSync()?.trim();

      if (inputStok?.toLowerCase() == 'batal' ||
          inputStok?.toLowerCase() == 'k' ||
          inputStok?.toLowerCase() == 'kembali') {
        print("\n[i] Penginputan barang baru dibatalkan.");
        return;
      }

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

    // 4. Konfirmasi Ringkasan Data Sebelum Simpan
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

    stdout.write("\nTekan [ENTER] untuk melanjutkan...");
    stdin.readLineSync();
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
