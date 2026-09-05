import 'dart:io';
import 'database_stok.dart';

/// Class Fitur: Menu Input Bilangan = Ganjil/Genap
/// Sesuai Kriteria Tugas: Menu input bilangan = ganjil/genap
/// Dilengkapi fitur analisis operasional stok gudang
class MenuGanjilGenap {
  final DatabaseStok _database;

  MenuGanjilGenap(this._database);

  /// Menjalankan menu analisis sifat ganjil/genap stok barang gudang
  void jalankan() {
    bool lanjut = true;

    while (lanjut) {
      print("\n${"=" * 60}");
      print(" MENU ANALISIS BILANGAN GANJIL / GENAP (STOK GUDANG)");
      print(" Kasus Logistik: Analisis Simetri Display & Bundling Barang");
      print("=" * 60);

      final listBarang = _database.semuaBarang;

      print("\n--- PILIH BARANG GUDANG UNTUK DIANALISIS ---");
      for (var b in listBarang) {
        print("[${b.id}] ${b.nama.padRight(28)} | Stok Saat Ini: ${b.stok.toInt()} ${b.satuan}");
      }
      print("-" * 50);

      stdout.write("Pilih ID Barang [1-${listBarang.length}] (ketik 0 untuk kembali ke Menu Utama): ");
      String? inputId = stdin.readLineSync()?.trim();

      if (inputId == '0' ||
          inputId?.toLowerCase() == 'k' ||
          inputId?.toLowerCase() == 'batal' ||
          inputId?.toLowerCase() == 'kembali') {
        print("\n[i] Kembali ke Menu Utama.");
        break;
      }

      int? id = int.tryParse(inputId ?? "");
      final barang = id != null ? _database.cariBerdasarkanId(id) : null;
      if (barang == null) {
        print("[!] Barang tidak ditemukan! Silakan masukkan ID yang sesuai.");
        continue;
      }

      int stokBulat = barang.stok.toInt();
      bool adalahGenap = stokBulat % 2 == 0;

      print("\n[✓] HASIL ANALISIS GANJIL/GENAP BARANG GUDANG:");
      print("Nama Barang   : ${barang.nama}");
      print("Jumlah Stok   : $stokBulat ${barang.satuan}");
      print("Sifat Angka   : ${adalahGenap ? 'GENAP' : 'GANJIL'}");
      print("Logika Rumus  : $stokBulat % 2 = ${stokBulat % 2}");
      print("------------------------------------------------------------");
      print("ANALISIS OPERASIONAL GUDANG:");
      if (adalahGenap) {
        print("• Stok barang berjumlah GENAP ($stokBulat).");
        print("• Barang ini siap ditata secara simetris berpasangan di rak display.");
        print("• Dapat langsung dibuat bundling 2-in-1 tanpa menyisakan item tercecer.");
      } else {
        print("• Stok barang berjumlah GANJIL ($stokBulat).");
        print("• Jika dikemas dalam paket bundle berpasangan, akan ada 1 ${barang.satuan} sisa.");
        print("• Rekomendasi: Disarankan menambah restock 1 ${barang.satuan} agar genap (${stokBulat + 1}),");
        print("  atau jual 1 ${barang.satuan} sebagai barang sample/display terpisah.");
      }

      stdout.write("\nApakah ingin menganalisis barang lain? [y/n]: ");
      final lanjutJawab = stdin.readLineSync()?.trim().toLowerCase();
      if (lanjutJawab != 'y') {
        lanjut = false;
        print("\n[i] Kembali ke Menu Utama.");
      }
    }
  }
}
