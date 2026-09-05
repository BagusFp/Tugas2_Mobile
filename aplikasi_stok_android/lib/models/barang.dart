/// Model class untuk merepresentasikan entitas Barang di Gudang
/// Menerapkan prinsip OOP: Encapsulation & Data Modeling
class Barang {
  final int id;
  final String nama;
  double _stok; // Private attribute dengan getter
  final String satuan;

  Barang({
    required this.id,
    required this.nama,
    required double stok,
    required this.satuan,
  }) : _stok = stok;

  /// Getter untuk mengakses jumlah stok barang
  double get stok => _stok;

  /// Menambah stok barang (Penjumlahan)
  void tambahStok(double jumlah) {
    if (jumlah <= 0) {
      throw ArgumentError("Jumlah penambahan harus lebih dari 0.");
    }
    _stok += jumlah;
  }

  /// Mengurangi stok barang (Pengurangan)
  void kurangStok(double jumlah) {
    if (jumlah <= 0) {
      throw ArgumentError("Jumlah pengurangan harus lebih dari 0.");
    }
    if (jumlah > _stok) {
      throw StateError("Stok tidak mencukupi! Stok saat ini: $_stok $satuan, diminta: $jumlah $satuan.");
    }
    _stok -= jumlah;
  }

  /// Konversi dari Objek ke Map JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'stok': _stok,
      'satuan': satuan,
    };
  }

  /// Factory constructor untuk membuat Objek dari Map JSON
  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'] as int,
      nama: map['nama'] as String,
      stok: (map['stok'] as num).toDouble(),
      satuan: map['satuan'] as String,
    );
  }
}
