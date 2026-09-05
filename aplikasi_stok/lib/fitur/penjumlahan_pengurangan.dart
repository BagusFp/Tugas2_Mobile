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
    bool kembali = false;

    while (!kembali) {
      print("\n${"=" * 60}");
      print(" MENU PENJUMLAHAN DAN PENGURANGAN ANGKA");
      print("=" * 60);
      print("1. Update Stok Barang Gudang (Penjumlahan & Pengurangan Realtime)");
      print("2. Kalkulator Bebas (Penjumlahan & Pengurangan Dua Angka)");
      print("0. Kembali ke Menu Utama");
      print("=" * 60);
      stdout.write("Pilih opsi [0-2]: ");
      String? opsi = stdin.readLineSync()?.trim();

      switch (opsi) {
        case '1':
          _prosesStokGudang();
          break;
        case '2':
          _prosesKalkulatorBebas();
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

  /// Fitur Utama: Penjumlahan/Pengurangan terhubung ke Database Lokal
  void _prosesStokGudang() {
    final listBarang = _database.semuaBarang;

    print("\n--- DAFTAR STOK BARANG DI DATABASE LOKAL ---");
    for (var b in listBarang) {
      print("[${b.id}] ${b.nama.padRight(28)} | Stok: ${b.stok} ${b.satuan}");
    }
    print("-" * 50);

    stdout.write("Pilih ID Barang yang ingin diupdate [1-${listBarang.length}] (ketik 0 untuk batal): ");
    String? inputId = stdin.readLineSync()?.trim();

    if (inputId == '0' || inputId?.toLowerCase() == 'k' || inputId?.toLowerCase() == 'batal') {
      print("[i] Pembaharuan stok dibatalkan.");
      return;
    }

    int? idDipilih = int.tryParse(inputId ?? "");
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
    print("0. Batal / Kembali");
    stdout.write("Pilih operasi [0-2]: ");
    String? jenis = stdin.readLineSync()?.trim();

    if (jenis == '0' || jenis?.toLowerCase() == 'batal' || jenis?.toLowerCase() == 'k') {
      print("[i] Operasi stok dibatalkan.");
      return;
    }

    if (jenis != '1' && jenis != '2') {
      print("[!] Pilihan operasi tidak valid!");
      return;
    }

    stdout.write(jenis == '1'
        ? "Jumlah stok masuk (+) [ketik 0 untuk batal]: "
        : "Jumlah stok keluar (-) [ketik 0 untuk batal]: ");
    String? inputJumlah = stdin.readLineSync()?.trim();

    if (inputJumlah == '0' || inputJumlah?.toLowerCase() == 'batal') {
      print("[i] Operasi stok dibatalkan.");
      return;
    }

    double? jumlah = double.tryParse(inputJumlah ?? "");

    if (jumlah == null || jumlah <= 0) {
      print("[!] Masukkan jumlah angka yang valid (lebih dari 0)!");
      return;
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

    stdout.write("\nTekan [ENTER] untuk melanjutkan...");
    stdin.readLineSync();
  }

  /// Fitur Alternatif: Operasi matematika dua angka murni
  void _prosesKalkulatorBebas() {
    print("\n--- KALKULATOR PENJUMLAHAN & PENGURANGAN BEBAS ---");
    stdout.write("Masukkan Angka Pertama (ketik 'k' untuk batal): ");
    String? inputA = stdin.readLineSync()?.trim();

    if (inputA?.toLowerCase() == 'k' || inputA?.toLowerCase() == 'batal') {
      print("[i] Kalkulator dibatalkan.");
      return;
    }

    double? a = double.tryParse(inputA ?? "");

    stdout.write("Masukkan Angka Kedua (ketik 'k' untuk batal): ");
    String? inputB = stdin.readLineSync()?.trim();

    if (inputB?.toLowerCase() == 'k' || inputB?.toLowerCase() == 'batal') {
      print("[i] Kalkulator dibatalkan.");
      return;
    }

    double? b = double.tryParse(inputB ?? "");

    if (a == null || b == null) {
      print("[!] Harap masukkan angka yang valid!");
      return;
    }

    double hasilJumlah = a + b;
    double hasilKurang = a - b;

    print("\n[✓] HASIL PERHITUNGAN:");
    print("Penjumlahan ($a + $b) = $hasilJumlah");
    print("Pengurangan ($a - $b) = $hasilKurang");

    stdout.write("\nTekan [ENTER] untuk melanjutkan...");
    stdin.readLineSync();
  }
}
