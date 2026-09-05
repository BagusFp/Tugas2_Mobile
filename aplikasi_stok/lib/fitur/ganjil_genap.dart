import 'dart:io';
import 'database_stok.dart';

/// Class Fitur: Menu Input Bilangan = Ganjil/Genap
/// Sesuai Kriteria Tugas: Menu input bilangan = ganjil/genap
/// Dilengkapi fitur analisis operasional stok gudang
class MenuGanjilGenap {
  final DatabaseStok _database;

  MenuGanjilGenap(this._database);

  /// Menjalankan menu ganjil/genap
  void jalankan() {
    print("\n${"=" * 60}");
    print(" MENU INPUT BILANGAN: GANJIL / GENAP");
    print("=" * 60);
    print("1. Cek Sifat Stok Barang di Gudang (Analisis Logistik)");
    print("2. Input Bilangan Bebas (Pemeriksaan Ganjil/Genap)");
    stdout.write("\nPilih opsi [1-2]: ");
    String? opsi = stdin.readLineSync()?.trim();

    if (opsi == '1') {
      _cekStokBarangGudang();
    } else if (opsi == '2') {
      _cekBilanganBebas();
    } else {
      print("[!] Opsi tidak valid!");
    }
  }

  /// Fitur Relevan: Menghubungkan pemeriksaan ganjil/genap dengan stok barang riil
  void _cekStokBarangGudang() {
    final listBarang = _database.semuaBarang;

    print("\n--- PILIH BARANG GUDANG UNTUK DIANALISIS ---");
    for (var b in listBarang) {
      print("[${b.id}] ${b.nama.padRight(28)} | Stok Saat Ini: ${b.stok.toInt()} ${b.satuan}");
    }
    print("-" * 50);

    stdout.write("Pilih ID Barang [1-${listBarang.length}]: ");
    int? id = int.tryParse(stdin.readLineSync()?.trim() ?? "");

    final barang = id != null ? _database.cariBerdasarkanId(id) : null;
    if (barang == null) {
      print("[!] Barang tidak ditemukan!");
      return;
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
  }

  /// Fitur Standar: Input bilangan bulat bebas
  void _cekBilanganBebas() {
    print("\n--- INPUT BILANGAN BEBAS ---");
    stdout.write("Masukkan sebuah bilangan bulat: ");
    int? angka = int.tryParse(stdin.readLineSync()?.trim() ?? "");

    if (angka == null) {
      print("[!] Input harus berupa bilangan bulat integer!");
      return;
    }

    bool adalahGenap = angka % 2 == 0;
    String statusTanda;
    if (angka > 0) {
      statusTanda = "Positif (+)";
    } else if (angka < 0) {
      statusTanda = "Negatif (-)";
    } else {
      statusTanda = "Nol (0)";
    }

    print("\n[✓] HASIL PEMERIKSAAN BILANGAN:");
    print("Angka Input   : $angka");
    print("Jenis Bilangan: ${adalahGenap ? 'GENAP' : 'GANJIL'}");
    print("Tanda Bilangan: $statusTanda");
    print("Penjelasan    : $angka ${adalahGenap ? 'habis dibagi 2 (sisa = 0)' : 'tidak habis dibagi 2 (sisa = ${angka.abs() % 2})'}.");
  }
}
