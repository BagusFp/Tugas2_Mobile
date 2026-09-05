import 'dart:io';

import 'package:aplikasi_stok/fitur/database_stok.dart';
import 'package:aplikasi_stok/fitur/login.dart';
import 'package:aplikasi_stok/fitur/data_kelompok.dart';
import 'package:aplikasi_stok/fitur/penjumlahan_pengurangan.dart';
import 'package:aplikasi_stok/fitur/perkalian_pembagian.dart';
import 'package:aplikasi_stok/fitur/ganjil_genap.dart';
import 'package:aplikasi_stok/fitur/total_angka.dart';
import 'package:aplikasi_stok/fitur/input_barang.dart';

/// Titik Masuk Utama (Entry Point) Aplikasi
/// Mengintegrasikan seluruh modul fitur berorientasi objek (OOP)
void main() {
  // 1. Inisialisasi Database Lokal & Seluruh Modul Fitur
  final database = DatabaseStok();
  final menuLogin = MenuLogin();
  final menuKelompok = MenuDataKelompok();
  final menuHitungStok = MenuPenjumlahanPengurangan(database);
  final menuKalkulasi = MenuPerkalianPembagian();
  final menuGanjilGenap = MenuGanjilGenap(database);
  final menuTotalAngka = MenuTotalAngka();
  final menuInputBarang = MenuInputBarang(database);

  print("\n${"=" * 60}");
  print(" APLIKASI MANAJEMEN GUDANG & OPERASI MATEMATIKA DART");
  print(" Tugas 2 - Pemrograman Berorientasi Objek (OOP)");
  print("=" * 60);

  // 2. Kriteria 1: Menu Login (Username & Password)
  bool berhasilLogin = menuLogin.jalankan();
  if (!berhasilLogin) {
    print("\n[!] Aplikasi ditutup karena belum terautentikasi.");
    return;
  }

  // 3. Loop Menu Utama Aplikasi
  bool programBerjalan = true;
  while (programBerjalan) {
    print("\n${"=" * 60}");
    print(" MENU UTAMA APLIKASI (User: ${menuLogin.userAktif?.username})");
    print("=" * 60);
    print("1. Data Kelompok");
    print("2. Menu Penjumlahan dan Pengurangan Angka");
    print("3. Menu Perkalian dan Pembagian Angka");
    print("4. Menu Input Bilangan = Ganjil / Genap");
    print("5. Menu Jumlah Total Angka dalam Suatu Field Input Data");
    print("6. Menu Input Barang Baru (Database Gudang)");
    print("0. Logout & Keluar");
    print("=" * 60);
    stdout.write("Pilih menu [0-6]: ");
    String? pilihan = stdin.readLineSync()?.trim();

    switch (pilihan) {
      case '1':
        // Kriteria 2: Data kelompok
        menuKelompok.tampilkan();
        break;
      case '2':
        // Kriteria 3: Menu penjumlahan dan pengurangan angka (Database Lokal)
        menuHitungStok.jalankan();
        break;
      case '3':
        // Kriteria 4: Perkalian dan pembagian angka
        menuKalkulasi.jalankan();
        break;
      case '4':
        // Kriteria 5: Menu input bilangan = ganjil/genap
        menuGanjilGenap.jalankan();
        break;
      case '5':
        // Kriteria 6: Menu Jumlah total angka dalam suatu field input data
        menuTotalAngka.jalankan();
        break;
      case '6':
        // Fitur Terpisah: Menu Input Barang Baru
        menuInputBarang.jalankan();
        break;
      case '0':
        programBerjalan = false;
        menuLogin.logout();
        print("\n[✓] Berhasil logout. Terima kasih telah menggunakan aplikasi!");
        break;
      default:
        print("\n[!] Pilihan tidak dikenali! Silakan pilih angka 0 sampai 6.");
    }

    if (programBerjalan) {
      stdout.write("\nTekan [ENTER] untuk kembali ke Menu Utama...");
      stdin.readLineSync();
    }
  }
}
