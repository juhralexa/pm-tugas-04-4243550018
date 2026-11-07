import 'dart:async';

import 'kendaraan.dart';

/// Dilempar saat kendaraan masuk tetapi parkiran sudah penuh.
class ParkirPenuh implements Exception {
  final int kapasitas;

  ParkirPenuh(this.kapasitas);

  @override
  String toString() => 'Parkiran penuh (kapasitas $kapasitas)';
}

class Parkiran {
  final int kapasitas;
  final List<Kendaraan> _parkir = []; // privat: hanya lewat masuk/keluar
  int _pendapatan = 0;
  final _kejadian = StreamController<String>.broadcast();

  Parkiran(this.kapasitas);

  int get sisa => kapasitas - _parkir.length;
  int get pendapatan => _pendapatan;
  Stream<String> get kejadian => _kejadian.stream;

  /// Palang masuk disimulasikan dengan Future.delayed.
  Future<void> masuk(Kendaraan k) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (sisa <= 0) {
      throw ParkirPenuh(kapasitas);
    }
    _parkir.add(k);
    _kejadian.add('MASUK $k (sisa $sisa)');
  }

  /// Palang keluar: hitung biaya, tambah pendapatan, kirim event.
  Future<int> keluar(Kendaraan k, DateTime waktuKeluar) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!_parkir.remove(k)) {
      throw StateError('$k tidak ada di parkiran');
    }
    final bayar = k.biaya(waktuKeluar);
    _pendapatan += bayar;
    _kejadian.add('KELUAR $k bayar Rp$bayar');
    return bayar;
  }

  Future<void> tutup() => _kejadian.close();
}