import 'dart:io';

/// Class Fitur: Menu Perkalian dan Pembagian Angka
/// Sesuai Kriteria Tugas: Perkalian dan pembagian angka
class MenuPerkalianPembagian {
  /// Menjalankan menu perkalian dan pembagian
  void jalankan() {
    bool kembali = false;

    while (!kembali) {
      print("\n${"=" * 60}");
      print(" MENU PERKALIAN DAN PEMBAGIAN ANGKA (OPERASIONAL GUDANG)");
      print("=" * 60);
      print("1. Hitung Total Kardus/Box (Perkalian ×)");
      print("2. Distribusi Stok ke Rak Gudang (Pembagian ÷ & Modulo %)");
      print("0. Kembali ke Menu Utama");
      print("=" * 60);
      stdout.write("Pilih opsi [0-2]: ");
      String? opsi = stdin.readLineSync()?.trim();

      switch (opsi) {
        case '1':
          _hitungPerkalianBox();
          break;
        case '2':
          _hitungPembagianRak();
          break;
        case '0':
        case 'k':
        case 'kembali':
          kembali = true;
          print("\n[i] Kembali ke Menu Utama.");
          break;
        default:
          print("\n[!] Pilihan tidak valid! Silakan pilih 0-2.");
      }
    }
  }

  void _hitungPerkalianBox() {
    print("\n--- PERHITUNGAN TOTAL DARI KARDUS/BOX (PERKALIAN) ---");
    stdout.write("Masukkan Jumlah Box/Dus (ketik 'k' untuk batal): ");
    String? inputBox = stdin.readLineSync()?.trim();
    if (inputBox?.toLowerCase() == 'k' || inputBox?.toLowerCase() == 'batal') {
      print("[i] Perhitungan perkalian box dibatalkan.");
      return;
    }
    double? box = double.tryParse(inputBox ?? "");

    stdout.write("Masukkan Isi Barang per Box (ketik 'k' untuk batal): ");
    String? inputIsi = stdin.readLineSync()?.trim();
    if (inputIsi?.toLowerCase() == 'k' || inputIsi?.toLowerCase() == 'batal') {
      print("[i] Perhitungan perkalian box dibatalkan.");
      return;
    }
    double? isi = double.tryParse(inputIsi ?? "");

    if (box == null || isi == null || box < 0 || isi < 0) {
      print("[!] Input harus berupa angka valid dan tidak negatif!");
      return;
    }

    double total = box * isi;
    print("\n[✓] HASIL PERKALIAN:");
    print("Rumus : $box box × $isi unit/box");
    print("Total : $total unit barang siap disimpan di gudang.");

    stdout.write("\nTekan [ENTER] untuk melanjutkan...");
    stdin.readLineSync();
  }

  void _hitungPembagianRak() {
    print("\n--- DISTRIBUSI STOK KE RAK GUDANG (PEMBAGIAN & MODULO) ---");
    stdout.write("Masukkan Total Jumlah Stok Barang (ketik 'k' untuk batal): ");
    String? inputTotal = stdin.readLineSync()?.trim();
    if (inputTotal?.toLowerCase() == 'k' || inputTotal?.toLowerCase() == 'batal') {
      print("[i] Perhitungan pembagian rak dibatalkan.");
      return;
    }
    int? total = int.tryParse(inputTotal ?? "");

    stdout.write("Masukkan Jumlah Rak Penampungan (ketik 'k' untuk batal): ");
    String? inputRak = stdin.readLineSync()?.trim();
    if (inputRak?.toLowerCase() == 'k' || inputRak?.toLowerCase() == 'batal') {
      print("[i] Perhitungan pembagian rak dibatalkan.");
      return;
    }
    int? rak = int.tryParse(inputRak ?? "");

    if (total == null || rak == null || total < 0 || rak <= 0) {
      print("[!] Input tidak valid! Jumlah rak harus lebih dari 0 dan stok tidak boleh negatif.");
      return;
    }

    int perRak = total ~/ rak; // Pembagian bulat
    int sisa = total % rak; // Modulo (sisa bagi)
    double presisi = total / rak;

    print("\n[✓] HASIL PEMBAGIAN & MODULO:");
    print("Total Stok Barang : $total unit");
    print("Dibagi ke         : $rak rak penyimpanan");
    print("Kapasitas per Rak : $perRak unit per rak (merata)");
    print("Sisa Stok (Modulo): $sisa unit (belum tertampung di rak)");
    print("Nilai Rata-rata   : ${presisi.toStringAsFixed(2)} unit/rak");

    stdout.write("\nTekan [ENTER] untuk melanjutkan...");
    stdin.readLineSync();
  }
}
