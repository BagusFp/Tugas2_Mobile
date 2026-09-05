# Aplikasi Manajemen Gudang & Operasi Matematika (Dart Console OOP)

Aplikasi terminal berbasis **Dart Console (CLI)** murni dengan arsitektur **Object-Oriented Programming (OOP)**. Dirancang dengan prinsip **1 Class = 1 File** dan penamaan file yang persis mencerminkan butir-butir penugasan.

---

## 📂 Struktur Proyek (Sesuai Kriteria Tugas)

```text
aplikasi_stok/
├── bin/
│   └── main.dart                     # Entry point utama (Inisialisasi & Menu Utama)
├── data/
│   └── data_stok.json                # Database lokal penyimpanan stok barang gudang
├── lib/
│   ├── models/
│   │   ├── user.dart                 # Class User (enkapsulasi username & private password)
│   │   ├── anggota.dart              # Class AnggotaKelompok (data nama & NIM mahasiswa)
│   │   └── barang.dart               # Class Barang (enkapsulasi stok & serialisasi JSON)
│   └── fitur/
│       ├── database_stok.dart        # Database lokal manajemen stok (read/write JSON)
│       ├── login.dart                # Kriteria 1: Menu login (username dan password)
│       ├── data_kelompok.dart        # Kriteria 2: Data kelompok
│       ├── penjumlahan_pengurangan.dart # Kriteria 3: Menu penjumlahan dan pengurangan angka
│       ├── perkalian_pembagian.dart  # Kriteria 4: Perkalian dan pembagian angka
│       ├── ganjil_genap.dart         # Kriteria 5: Menu input bilangan = ganjil/genap
│       └── total_angka.dart          # Kriteria 6: Menu Jumlah total angka dalam suatu field input data
├── pubspec.yaml                      # Konfigurasi Dart murni
└── README.md                         # Dokumentasi proyek
```

---

## 🚀 Cara Menjalankan Program

Buka terminal di folder proyek:
```bash
cd d:\Kuliah\Mobile\Tugas2\aplikasi_stok
dart run bin/main.dart
```

---

## 🔑 Kredensial Login Demo
- **Username**: `admin`
- **Password**: `admin123`

---

## ✨ Fitur-Fitur Utama

1. **Menu Login**: Otentikasi username & password dengan proteksi batas percobaan.
2. **Data Kelompok**: Menampilkan data anggota kelompok mahasiswa pengembang (Nama & NIM).
3. **Menu Penjumlahan dan Pengurangan Angka (Database Lokal)**:
   - Menampilkan daftar stok barang gudang secara realtime dari database lokal `data/data_stok.json`.
   - Menambah stok masuk (penjumlahan `+`) atau mengurangi stok keluar (pengurangan `-`).
   - Menyediakan kalkulator bebas untuk operasi penjumlahan/pengurangan 2 angka.
4. **Menu Perkalian dan Pembagian Angka**:
   - Perkalian kardus/box $\times$ isi per box.
   - Pembagian stok ke rak gudang beserta sisa barang menggunakan operator modulo (`%`).
5. **Menu Input Bilangan = Ganjil / Genap**:
   - **Cek Stok Barang Gudang**: Memilih barang gudang, mendeteksi apakah stok bernilai ganjil/genap, dan memberikan rekomendasi logistik penataan display/packing.
   - **Input Bilangan Bebas**: Memeriksa bilangan bulat sembarang apakah ganjil/genap dan positif/negatif.
6. **Menu Jumlah Total Angka dalam Suatu Field Input Data**:
   - Membaca satu baris (*field*) input berisi deretan angka (dipisahkan koma atau spasi).
   - Menghitung **Jumlah Total Angka**, Nilai Rata-rata, Nilai Tertinggi (Maks), Nilai Terendah (Min), dan Akumulasi Digit.
