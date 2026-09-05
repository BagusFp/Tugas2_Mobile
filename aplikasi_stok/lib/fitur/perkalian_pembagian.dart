import 'dart:io';

/// Class Fitur: Menu Perkalian dan Pembagian Angka
/// Sesuai Kriteria Tugas: Perkalian dan pembagian angka
class MenuPerkalianPembagian {
  /// Menjalankan menu perkalian dan pembagian
  void jalankan() {
    print("\n${"=" * 60}");
    print(" MENU PERKALIAN DAN PEMBAGIAN ANGKA");
    print("=" * 60);
    print("1. Hitung Total Kardus/Box (Perkalian ×)");
    print("2. Distribusi Stok ke Rak Gudang (Pembagian ÷ & Modulo %)");
    print("3. Kalkulator Bebas Dua Angka (Perkalian & Pembagian)");
    stdout.write("\nPilih opsi [1-3]: ");
    String? opsi = stdin.readLineSync()?.trim();

    switch (opsi) {
      case '1':
        _hitungPerkalianBox();
        break;
      case '2':
        _hitungPembagianRak();
        break;
      case '3':
        _kalkulatorBebas();
        break;
      default:
        print("[!] Pilihan tidak valid!");
    }
  }

  void _hitungPerkalianBox() {
    print("\n--- PERHITUNGAN TOTAL DARI KARDUS/BOX (PERKALIAN) ---");
    stdout.write("Masukkan Jumlah Box/Dus     : ");
    double? box = double.tryParse(stdin.readLineSync()?.trim() ?? "");
    stdout.write("Masukkan Isi Barang per Box : ");
    double? isi = double.tryParse(stdin.readLineSync()?.trim() ?? "");

    if (box == null || isi == null || box < 0 || isi < 0) {
      print("[!] Input harus berupa angka valid dan tidak negatif!");
      return;
    }

    double total = box * isi;
    print("\n[✓] HASIL PERKALIAN:");
    print("Rumus : $box box × $isi unit/box");
    print("Total : $total unit barang siap disimpan di gudang.");
  }

  void _hitungPembagianRak() {
    print("\n--- DISTRIBUSI STOK KE RAK GUDANG (PEMBAGIAN & MODULO) ---");
    stdout.write("Masukkan Total Jumlah Stok Barang : ");
    int? total = int.tryParse(stdin.readLineSync()?.trim() ?? "");
    stdout.write("Masukkan Jumlah Rak Penampungan   : ");
    int? rak = int.tryParse(stdin.readLineSync()?.trim() ?? "");

    if (total == null || rak == null || total < 0 || rak <= 0) {
      print("[!] Input tidak valid! Jumlah rak harus lebih dari 0 dan stok tidak boleh negatif.");
      return;
    }

    int perRak = total ~/ rak;  // Pembagian bulat
    int sisa = total % rak;     // Modulo (sisa bagi)
    double presisi = total / rak;

    print("\n[✓] HASIL PEMBAGIAN & MODULO:");
    print("Total Stok Barang : $total unit");
    print("Dibagi ke         : $rak rak penyimpanan");
    print("Kapasitas per Rak : $perRak unit per rak (merata)");
    print("Sisa Stok (Modulo): $sisa unit (belum tertampung di rak)");
    print("Nilai Rata-rata   : ${presisi.toStringAsFixed(2)} unit/rak");
  }

  void _kalkulatorBebas() {
    print("\n--- KALKULATOR PERKALIAN & PEMBAGIAN BEBAS ---");
    stdout.write("Masukkan Angka Pertama : ");
    double? a = double.tryParse(stdin.readLineSync()?.trim() ?? "");
    stdout.write("Masukkan Angka Kedua   : ");
    double? b = double.tryParse(stdin.readLineSync()?.trim() ?? "");

    if (a == null || b == null) {
      print("[!] Masukkan angka yang valid!");
      return;
    }

    double hasilKali = a * b;
    print("\n[✓] HASIL:");
    print("Perkalian ($a × $b) = $hasilKali");

    if (b == 0) {
      print("Pembagian ($a ÷ $b) = Tidak terdefinisi (pembagi tidak boleh nol)");
    } else {
      double hasilBagi = a / b;
      print("Pembagian ($a ÷ $b) = ${hasilBagi.toStringAsFixed(4)}");
    }
  }
}
