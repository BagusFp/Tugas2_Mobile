import 'package:flutter/material.dart';
import 'data_gudang.dart';

/// Halaman untuk menampilkan data kelompok mahasiswa (Kriteria 2)
class HalamanDataKelompok extends StatelessWidget {
  const HalamanDataKelompok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Kelompok Mahasiswa"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DataGudang.daftarAnggota.length,
        itemBuilder: (context, index) {
          final anggota = DataGudang.daftarAnggota[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Text("${index + 1}"),
              ),
              title: Text(
                anggota["nama"] ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text("NIM: ${anggota["nim"]}"),
            ),
          );
        },
      ),
    );
  }
}
