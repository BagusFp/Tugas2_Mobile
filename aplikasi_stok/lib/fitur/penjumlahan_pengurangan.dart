import 'dart:io';
import 'database_stok.dart';

/// Class Fitur: Menu Penjumlahan dan Pengurangan Angka
/// Sesuai Kriteria Tugas: Menu penjumlahan dan pengurangan angka
/// Terintegrasi dengan Database Lokal Stok Barang
class MenuPenjumlahanPengurangan {
  final DatabaseStok _database;

  MenuPenjumlahanPengurangan(this._database);

  /// Menjalankan menu penjumlahan dan pengurangan
  void jalankan() {
    print("\n${"=" * 60}");
    print(" MENU PENJUMLAHAN DAN PENGURANGAN ANGKA");
    print("=" * 60);
    print("1. Update Stok Barang Gudang (Penjumlahan & Pengurangan Realtime)");
    print("2. Kalkulator Bebas (Penjumlahan & Pengurangan Dua Angka)");
    stdout.write("\nPilih opsi [1-2]: ");
    String? opsi = stdin.readLineSync()?.trim();

    if (opsi == '1') {
      _prosesStokGudang();
    } else if (opsi == '2') {
      _prosesKalkulatorBebas();
    } else {
      print("[!] Opsi tidak valid!");
    }
  }

  /// Fitur Utama: Penjumlahan/Pengurangan terhubung ke Database Lokal
  void _prosesStokGudang() {
    final listBarang = _database.semuaBarang;

    print("\n--- DAFTAR STOK BARANG DI DATABASE LOKAL ---");
    for (var b in listBarang) {
      print("[${b.id}] ${b.nama.padRight(28)} | Stok: ${b.stok} ${b.satuan}");
    }
    print("-" * 50);

    stdout.write("Pilih ID Barang yang ingin diupdate [1-${listBarang.length}]: ");
    int? idDipilih = int.tryParse(stdin.readLineSync()?.trim() ?? "");

    final barang = idDipilih != null ? _database.cariBerdasarkanId(idDipilih) : null;
    if (barang == null) {
      print("[!] ID barang tidak ditemukan!");
      return;
    }

    print("\nBarang Dipilih : ${barang.nama}");
    print("Stok Saat Ini  : ${barang.stok} ${barang.satuan}");
    print("---------------------------------------------");
    print("1. Tambah Stok Masuk  (Operasi Penjumlahan +)");
    print("2. Kurang Stok Keluar (Operasi Pengurangan -)");
    stdout.write("Pilih operasi [1-2]: ");
    String? jenis = stdin.readLineSync()?.trim();

    if (jenis != '1' && jenis != '2') {
      print("[!] Pilihan operasi tidak valid!");
      return;
    }

    stdout.write(jenis == '1' ? "Jumlah stok masuk (+): " : "Jumlah stok keluar (-): ");
    double? jumlah = double.tryParse(stdin.readLineSync()?.trim() ?? "");

    if (jumlah == null || jumlah <= 0) {
      print("[!] Masukkan jumlah angka yang valid (lebih dari 0)!");
      return;
    }

    double stokAwal = barang.stok;

    try {
      if (jenis == '1') {
        _database.tambahStokBarang(barang.id, jumlah);
        print("\n[✓] PENJUMALAHAN STOK BERHASIL!");
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
  }

  /// Fitur Alternatif: Operasi matematika dua angka murni
  void _prosesKalkulatorBebas() {
    print("\n--- KALKULATOR PENJUMLAHAN & PENGURANGAN BEBAS ---");
    stdout.write("Masukkan Angka Pertama : ");
    double? a = double.tryParse(stdin.readLineSync()?.trim() ?? "");
    stdout.write("Masukkan Angka Kedua   : ");
    double? b = double.tryParse(stdin.readLineSync()?.trim() ?? "");

    if (a == null || b == null) {
      print("[!] Harap masukkan angka yang valid!");
      return;
    }

    double hasilJumlah = a + b;
    double hasilKurang = a - b;

    print("\n[✓] HASIL PERHITUNGAN:");
    print("Penjumlahan ($a + $b) = $hasilJumlah");
    print("Pengurangan ($a - $b) = $hasilKurang");
  }
}
