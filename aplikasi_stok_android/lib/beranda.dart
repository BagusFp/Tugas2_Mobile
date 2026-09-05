import 'package:flutter/material.dart';
import 'data_kelompok.dart';
import 'penjumlahan_pengurangan.dart';
import 'perkalian_pembagian.dart';
import 'ganjil_genap.dart';
import 'total_angka.dart';
import 'input_barang.dart';
import 'main.dart';

/// Halaman Menu Utama / Dashboard Aplikasi
class HalamanBeranda extends StatelessWidget {
  final String username;

  const HalamanBeranda({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Utama Gudang"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Kembali ke halaman Login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HalamanLogin()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner Selamat Datang
          Card(
            color: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sistem Manajemen Stok & Operasi Matematika",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Halo, $username!",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            "Pilih Menu Aplikasi:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Menu 1: Data Kelompok
          _menuItem(
            context: context,
            nomor: "1",
            judul: "Data Kelompok",
            deskripsi: "Daftar nama dan NIM anggota pengembang",
            ikon: Icons.group,
            warnaIkon: Colors.indigo,
            tujuan: const HalamanDataKelompok(),
          ),

          // Menu 2: Penjumlahan dan Pengurangan
          _menuItem(
            context: context,
            nomor: "2",
            judul: "Penjumlahan & Pengurangan Stok",
            deskripsi: "Update stok masuk (+) dan stok keluar (-)",
            ikon: Icons.add_circle_outline,
            warnaIkon: Colors.green,
            tujuan: const HalamanPenjumlahanPengurangan(),
          ),

          // Menu 3: Perkalian dan Pembagian
          _menuItem(
            context: context,
            nomor: "3",
            judul: "Perkalian & Pembagian Angka",
            deskripsi: "Hitung total box (×) & distribusi rak gudang (÷, %)",
            ikon: Icons.calculate_outlined,
            warnaIkon: Colors.orange,
            tujuan: const HalamanPerkalianPembagian(),
          ),

          // Menu 4: Ganjil / Genap
          _menuItem(
            context: context,
            nomor: "4",
            judul: "Analisis Ganjil / Genap Stok",
            deskripsi: "Cek sifat stok ganjil/genap untuk penataan display rak",
            ikon: Icons.balance,
            warnaIkon: Colors.purple,
            tujuan: const HalamanGanjilGenap(),
          ),

          // Menu 5: Total Angka dalam Field Input
          _menuItem(
            context: context,
            nomor: "5",
            judul: "Total Angka dalam Field Input",
            deskripsi: "Hitung total deret angka dalam satu input data",
            ikon: Icons.functions,
            warnaIkon: Colors.teal,
            tujuan: const HalamanTotalAngka(),
          ),

          // Menu 6: Input Barang Baru (Database Gudang)
          _menuItem(
            context: context,
            nomor: "6",
            judul: "Input Barang Baru (Database Gudang)",
            deskripsi: "Daftarkan jenis barang baru ke database gudang",
            ikon: Icons.add_box_outlined,
            warnaIkon: Colors.red,
            tujuan: const HalamanInputBarang(),
          ),
        ],
      ),
    );
  }

  // Widget bantuan untuk membuat tombol menu yang rapi dan mudah dibaca
  Widget _menuItem({
    required BuildContext context,
    required String nomor,
    required String judul,
    required String deskripsi,
    required IconData ikon,
    required Color warnaIkon,
    required Widget tujuan,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: warnaIkon.withAlpha(40),
          child: Icon(ikon, color: warnaIkon),
        ),
        title: Text(
          judul,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(deskripsi),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => tujuan),
          );
        },
      ),
    );
  }
}
