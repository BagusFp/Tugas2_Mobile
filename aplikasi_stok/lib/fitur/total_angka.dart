import 'dart:io';

/// Class Fitur: Menu Jumlah Total Angka dalam Suatu Field Input Data
/// Sesuai Kriteria Tugas: Menu Jumlah total angka dalam suatu field input data
class MenuTotalAngka {
  /// Menjalankan menu perhitungan total angka
  void jalankan() {
    print("\n${"=" * 60}");
    print(" MENU JUMLAH TOTAL ANGKA DALAM SUATU FIELD INPUT DATA");
    print("=" * 60);
    print("Petunjuk: Masukkan beberapa angka sekaligus dalam SATU FIELD input.");
    print("Pemisah antar angka dapat berupa koma (,) atau spasi.");
    print("Contoh input: 15, 30, 45, 20, 10\n");

    stdout.write("Field Input Data Angka: ");
    String input = stdin.readLineSync()?.trim() ?? "";

    if (input.isEmpty) {
      print("[!] Field input data tidak boleh kosong!");
      return;
    }

    // Parsing seluruh angka dari dalam field input data
    List<double> deretAngka = _ekstrakAngkaDariField(input);

    if (deretAngka.isEmpty) {
      print("[!] Tidak ditemukan format angka yang valid dalam field input tersebut!");
      return;
    }

    // Perhitungan Total, Rata-rata, Nilai Tertinggi, Nilai Terendah
    double totalJumlah = deretAngka.reduce((a, b) => a + b);
    double rataRata = totalJumlah / deretAngka.length;
    double nilaiMaks = deretAngka.reduce((a, b) => a > b ? a : b);
    double nilaiMin = deretAngka.reduce((a, b) => a < b ? a : b);

    // Akumulasi total per digit angka
    int totalDigit = _hitungTotalDigit(deretAngka);

    print("\n${"=" * 60}");
    print(" [✓] HASIL PERHITUNGAN FIELD INPUT DATA");
    print("=" * 60);
    print("Data Angka Terinput    : ${deretAngka.map((e) => e % 1 == 0 ? e.toInt() : e).join(', ')}");
    print("Banyaknya Angka (n)    : ${deretAngka.length} angka");
    print("------------------------------------------------------------");
    print("★ JUMLAH TOTAL ANGKA   : $totalJumlah");
    print("------------------------------------------------------------");
    print("Nilai Rata-rata        : ${rataRata.toStringAsFixed(2)}");
    print("Nilai Tertinggi (Maks) : $nilaiMaks");
    print("Nilai Terendah (Min)   : $nilaiMin");
    print("Total Akumulasi Digit  : $totalDigit");
    print("=" * 60);
  }

  /// Mengekstrak potongan string menjadi List<double>
  List<double> _ekstrakAngkaDariField(String teks) {
    String bersih = teks.replaceAll(',', ' ').replaceAll(';', ' ');
    List<String> potongan = bersih.split(' ');
    List<double> hasil = [];

    for (var p in potongan) {
      String item = p.trim();
      if (item.isNotEmpty) {
        double? angka = double.tryParse(item);
        if (angka != null) {
          hasil.add(angka);
        }
      }
    }
    return hasil;
  }

  /// Menghitung akumulasi seluruh digit angka
  int _hitungTotalDigit(List<double> deret) {
    int total = 0;
    for (var a in deret) {
      String str = a.toString().replaceAll('.', '').replaceAll('-', '');
      for (int i = 0; i < str.length; i++) {
        int? d = int.tryParse(str[i]);
        if (d != null) total += d;
      }
    }
    return total;
  }
}
