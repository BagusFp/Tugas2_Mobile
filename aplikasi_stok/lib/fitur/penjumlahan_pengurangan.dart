import 'dart:io';
import 'database_stok.dart';

/// Class Fitur: Menu Penjumlahan dan Pengurangan Angka
/// Sesuai Kriteria Tugas: Menu penjumlahan dan pengurangan angka
/// Terintegrasi dengan Database Lokal Stok Barang
class MenuPenjumlahanPengurangan {
  final DatabaseStok _database;

  MenuPenjumlahanPengurangan(this._database);

  /// Menjalankan menu penjumlahan dan pengurangan stok barang gudang
  void jalankan() {
    bool lanjut = true;

    while (lanjut) {
      print("\n${"=" * 60}");
      print(" MENU PENJUMLAHAN DAN PENGURANGAN STOK GUDANG");
      print(" Operasi: Penjumlahan (+) Stok Masuk & Pengurangan (-) Stok Keluar");
      print("=" * 60);

      final listBarang = _database.semuaBarang;

      print("\n--- DAFTAR STOK BARANG DI DATABASE LOKAL ---");
      for (var b in listBarang) {
        print("[${b.id}] ${b.nama.padRight(28)} | Stok: ${b.stok} ${b.satuan}");
      }
      print("-" * 50);

      stdout.write("Pilih ID Barang yang ingin diupdate [1-${listBarang.length}] (ketik 0 untuk kembali ke Menu Utama): ");
      String? inputId = stdin.readLineSync()?.trim();

      if (inputId == '0' ||
          inputId?.toLowerCase() == 'k' ||
          inputId?.toLowerCase() == 'batal' ||
          inputId?.toLowerCase() == 'kembali') {
        print("\n[i] Kembali ke Menu Utama.");
        break;
      }

      int? idDipilih = int.tryParse(inputId ?? "");
      final barang = idDipilih != null ? _database.cariBerdasarkanId(idDipilih) : null;
      if (barang == null) {
        print("[!] ID barang tidak ditemukan! Silakan masukkan ID yang sesuai.");
        continue;
      }

      print("\nBarang Dipilih : ${barang.nama}");
      print("Stok Saat Ini  : ${barang.stok} ${barang.satuan}");
      print("---------------------------------------------");
      print("1. Tambah Stok Masuk  (Operasi Penjumlahan +)");
      print("2. Kurang Stok Keluar (Operasi Pengurangan -)");
      print("0. Batal / Kembali");
      stdout.write("Pilih operasi [0-2]: ");
      String? jenis = stdin.readLineSync()?.trim();

      if (jenis == '0' || jenis?.toLowerCase() == 'batal' || jenis?.toLowerCase() == 'k') {
        print("[i] Operasi stok dibatalkan.");
        continue;
      }

      if (jenis != '1' && jenis != '2') {
        print("[!] Pilihan operasi tidak valid!");
        continue;
      }

      stdout.write(jenis == '1'
          ? "Jumlah stok masuk (+) [ketik 0 untuk batal]: "
          : "Jumlah stok keluar (-) [ketik 0 untuk batal]: ");
      String? inputJumlah = stdin.readLineSync()?.trim();

      if (inputJumlah == '0' || inputJumlah?.toLowerCase() == 'batal') {
        print("[i] Operasi stok dibatalkan.");
        continue;
      }

      double? jumlah = double.tryParse(inputJumlah ?? "");

      if (jumlah == null || jumlah <= 0) {
        print("[!] Masukkan jumlah angka yang valid (lebih dari 0)!");
        continue;
      }

      double stokAwal = barang.stok;

      try {
        if (jenis == '1') {
          _database.tambahStokBarang(barang.id, jumlah);
          print("\n[✓] PENJUMLAHAN STOK BERHASIL!");
          print("Perhitungan Matematika : $stokAwal + $jumlah = ${barang.stok}");
          print("Stok akhir '${barang.nama}' sekarang: ${barang.stok} ${barang.satuan}");
        } else {
          _database.kurangStokBarang(barang.id, jumlah);
          print("\n[✓] PENGURANGAN STOK BERHASIL!");
          print("Perhitungan Matematika : $stokAwal - $jumlah = ${barang.stok}");
          print("Stok akhir '${barang.nama}' sekarang: ${barang.stok} ${barang.satuan}");
        }
        print("(Data otomatis tersimpan ke file database lokal)");
      } catch (e) {
        print("\n[X] Operasi gagal: $e");
      }

      stdout.write("\nApakah ingin mengupdate stok barang lain? [y/n]: ");
      final lanjutJawab = stdin.readLineSync()?.trim().toLowerCase();
      if (lanjutJawab != 'y') {
        lanjut = false;
        print("\n[i] Kembali ke Menu Utama.");
      }
    }
  }
}
