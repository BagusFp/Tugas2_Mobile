import 'dart:convert';
import 'dart:io';
import '../models/barang.dart';

/// Class Database Lokal untuk mengelola penyimpanan data stok barang
/// Menerapkan prinsip OOP: Repository Pattern & File Persistence
class DatabaseStok {
  final String _pathFile = 'data/data_stok.json';
  final List<Barang> _daftarBarang = [];

  DatabaseStok() {
    _inisialisasiDatabase();
  }

  /// Membaca data dari file lokal JSON atau membuat data bawaan jika belum ada
  void _inisialisasiDatabase() {
    final file = File(_pathFile);

    if (file.existsSync()) {
      try {
        final konten = file.readAsStringSync();
        final List<dynamic> dataJson = jsonDecode(konten);
        _daftarBarang.clear();
        for (var item in dataJson) {
          _daftarBarang.add(Barang.fromMap(item as Map<String, dynamic>));
        }
        return;
      } catch (_) {
        // Jika file korup, gunakan data bawaan
      }
    }

    // Data awal (Seed Data) gudang
    _daftarBarang.addAll([
      Barang(id: 1, nama: "Beras Premium 5kg", stok: 25.0, satuan: "karung"),
      Barang(id: 2, nama: "Minyak Goreng 2L", stok: 14.0, satuan: "pouch"),
      Barang(id: 3, nama: "Gula Pasir Kristal 1kg", stok: 30.0, satuan: "kg"),
      Barang(id: 4, nama: "Kopi Bubuk Robusta 250g", stok: 17.0, satuan: "pack"),
      Barang(id: 5, nama: "Tepung Terigu Serbaguna 1kg", stok: 8.0, satuan: "kg"),
    ]);

    simpanKeFile();
  }

  /// Menyimpan seluruh data barang ke file JSON lokal
  void simpanKeFile() {
    try {
      final direktori = Directory('data');
      if (!direktori.existsSync()) {
        direktori.createSync(recursive: true);
      }

      final file = File(_pathFile);
      final listMap = _daftarBarang.map((b) => b.toMap()).toList();
      file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(listMap));
    } catch (e) {
      print("[!] Gagal menyimpan ke database lokal: $e");
    }
  }

  /// Mengambil semua daftar barang di gudang
  List<Barang> get semuaBarang => List.unmodifiable(_daftarBarang);

  /// Mencari barang berdasarkan ID
  Barang? cariBerdasarkanId(int id) {
    for (var b in _daftarBarang) {
      if (b.id == id) return b;
    }
    return null;
  }

  /// Menambah stok barang dan menyimpan otomatis
  void tambahStokBarang(int id, double jumlah) {
    final barang = cariBerdasarkanId(id);
    if (barang == null) throw ArgumentError("Barang dengan ID $id tidak ditemukan.");
    barang.tambahStok(jumlah);
    simpanKeFile();
  }

  /// Mengurangi stok barang dan menyimpan otomatis
  void kurangStokBarang(int id, double jumlah) {
    final barang = cariBerdasarkanId(id);
    if (barang == null) throw ArgumentError("Barang dengan ID $id tidak ditemukan.");
    barang.kurangStok(jumlah);
    simpanKeFile();
  }
}
