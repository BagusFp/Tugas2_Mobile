import 'package:flutter/material.dart';
import 'data_gudang.dart';

/// Halaman Penjumlahan dan Pengurangan Angka (Kriteria 3)
/// Studi Kasus: Tambah Stok Masuk (+) & Kurang Stok Keluar (-) Barang Gudang
class HalamanPenjumlahanPengurangan extends StatefulWidget {
  const HalamanPenjumlahanPengurangan({super.key});

  @override
  State<HalamanPenjumlahanPengurangan> createState() =>
      _HalamanPenjumlahanPenguranganState();
}

class _HalamanPenjumlahanPenguranganState
    extends State<HalamanPenjumlahanPengurangan> {
  // Controller untuk membaca input jumlah angka
  final TextEditingController _jumlahController = TextEditingController();

  // Menyimpan barang yang sedang dipilih
  int? _idDipilih;

  // Fungsi Operasi Penjumlahan (+)
  void _tambahStok() {
    final jumlah = int.tryParse(_jumlahController.text.trim());

    if (_idDipilih == null) {
      _tampilkanPesan("Silakan pilih barang terlebih dahulu!");
      return;
    }
    if (jumlah == null || jumlah <= 0) {
      _tampilkanPesan("Masukkan angka jumlah yang valid (lebih dari 0)!");
      return;
    }

    setState(() {
      final barang = DataGudang.daftarBarang
          .firstWhere((item) => item["id"] == _idDipilih);
      final stokLama = barang["stok"];
      barang["stok"] = stokLama + jumlah; // Operasi Penjumlahan (+)
      _tampilkanPesan(
          "Penjumlahan Berhasil: $stokLama + $jumlah = ${barang["stok"]} ${barang["satuan"]}");
      _jumlahController.clear();
    });
  }

  // Fungsi Operasi Pengurangan (-)
  void _kurangStok() {
    final jumlah = int.tryParse(_jumlahController.text.trim());

    if (_idDipilih == null) {
      _tampilkanPesan("Silakan pilih barang terlebih dahulu!");
      return;
    }
    if (jumlah == null || jumlah <= 0) {
      _tampilkanPesan("Masukkan angka jumlah yang valid (lebih dari 0)!");
      return;
    }

    setState(() {
      final barang = DataGudang.daftarBarang
          .firstWhere((item) => item["id"] == _idDipilih);
      final stokLama = barang["stok"];

      if (stokLama - jumlah < 0) {
        _tampilkanPesan("Gagal: Stok tidak cukup untuk dikurangi!");
        return;
      }

      barang["stok"] = stokLama - jumlah; // Operasi Pengurangan (-)
      _tampilkanPesan(
          "Pengurangan Berhasil: $stokLama - $jumlah = ${barang["stok"]} ${barang["satuan"]}");
      _jumlahController.clear();
    });
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penjumlahan & Pengurangan Stok"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "1. Pilih Barang Gudang:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Daftar Barang
            ...DataGudang.daftarBarang.map((barang) {
              final isDipilih = _idDipilih == barang["id"];
              return Card(
                color: isDipilih ? Colors.blue.shade50 : Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isDipilih ? Colors.blue : Colors.grey.shade300,
                    width: isDipilih ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(barang["nama"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text(
                    "Stok: ${barang["stok"]} ${barang["satuan"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDipilih ? Colors.blue : Colors.black87,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _idDipilih = barang["id"];
                    });
                  },
                ),
              );
            }),

            const SizedBox(height: 20),
            const Text(
              "2. Masukkan Jumlah Angka Operasi:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Input Angka
            TextField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Jumlah (Angka)",
                hintText: "Contoh: 5",
              ),
            ),

            const SizedBox(height: 16),

            // Tombol Operasi Penjumlahan dan Pengurangan
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _tambahStok,
                    icon: const Icon(Icons.add),
                    label: const Text("Tambah (+)"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _kurangStok,
                    icon: const Icon(Icons.remove),
                    label: const Text("Kurang (-)"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
