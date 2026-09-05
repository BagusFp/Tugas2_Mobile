import 'package:flutter/material.dart';
import 'data_gudang.dart';

/// Halaman Input Barang Baru (Menu 6)
/// Studi Kasus: Pendaftaran Barang Baru ke Database Gudang
class HalamanInputBarang extends StatefulWidget {
  const HalamanInputBarang({super.key});

  @override
  State<HalamanInputBarang> createState() => _HalamanInputBarangState();
}

class _HalamanInputBarangState extends State<HalamanInputBarang> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  void _prosesTambahBarang() {
    final nama = _namaController.text.trim();
    final satuan = _satuanController.text.trim();
    final stokTeks = _stokController.text.trim();

    if (nama.isEmpty) {
      _tampilkanPesan("Nama barang tidak boleh kosong!");
      return;
    }

    if (satuan.isEmpty) {
      _tampilkanPesan("Satuan barang tidak boleh kosong!");
      return;
    }

    final stokAwal = int.tryParse(stokTeks);
    if (stokAwal == null || stokAwal < 0) {
      _tampilkanPesan("Stok awal harus berupa angka bulat positif (>= 0)!");
      return;
    }

    // Cek duplikasi nama barang
    final isDuplikat = DataGudang.daftarBarang.any(
      (item) => (item["nama"] as String).toLowerCase() == nama.toLowerCase(),
    );

    if (isDuplikat) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Peringatan Duplikasi"),
          content: Text(
            "Barang dengan nama '$nama' sudah terdaftar di database gudang. Apakah Anda tetap ingin memproses pendaftaran?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _simpanBarang(nama, satuan, stokAwal);
              },
              child: const Text("Tetap Simpan"),
            ),
          ],
        ),
      );
    } else {
      _simpanBarang(nama, satuan, stokAwal);
    }
  }

  void _simpanBarang(String nama, String satuan, int stokAwal) {
    setState(() {
      int maxId = 0;
      for (var item in DataGudang.daftarBarang) {
        if ((item["id"] as int) > maxId) {
          maxId = item["id"] as int;
        }
      }

      final newId = maxId + 1;
      DataGudang.daftarBarang.add({
        "id": newId,
        "nama": nama,
        "stok": stokAwal,
        "satuan": satuan,
      });

      _namaController.clear();
      _satuanController.clear();
      _stokController.clear();
    });

    _tampilkanPesan("Berhasil! Barang '$nama' telah didaftarkan ke Database Gudang.");
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Barang Baru (Database)"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card Form Input
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Formulir Input Barang Baru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Daftarkan item barang baru ke dalam database stok gudang",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Divider(height: 24),

                    // Input 1: Nama Barang
                    TextField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nama Barang Baru",
                        hintText: "Contoh: Gula Pasir Premium 1kg",
                        prefixIcon: Icon(Icons.inventory_2_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Input 2: Satuan Barang
                    TextField(
                      controller: _satuanController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Satuan Barang",
                        hintText: "Contoh: pcs, kg, pouch, box, karung",
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Input 3: Stok Awal
                    TextField(
                      controller: _stokController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Stok Awal Barang",
                        hintText: "Contoh: 20",
                        prefixIcon: Icon(Icons.numbers_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Submit
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _prosesTambahBarang,
                        icon: const Icon(Icons.add_box),
                        label: const Text(
                          "Daftarkan Barang Baru",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Header List Barang Saat Ini
            Text(
              "Daftar Barang Gudang Saat Ini (${DataGudang.daftarBarang.length} item):",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // ListView List Barang Gudang
            if (DataGudang.daftarBarang.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text("Belum ada barang di database gudang."),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DataGudang.daftarBarang.length,
                itemBuilder: (context, index) {
                  final barang = DataGudang.daftarBarang[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          "#${barang["id"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      title: Text(
                        barang["nama"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Satuan: ${barang["satuan"]}"),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Text(
                          "Stok: ${barang["stok"]} ${barang["satuan"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
