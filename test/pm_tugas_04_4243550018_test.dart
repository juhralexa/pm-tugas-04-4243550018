import 'package:pm_tugas_04_4243550018/kendaraan.dart';

void main() {
  final masuk = DateTime(2026, 11, 7, 8);
  final daftar = <Kendaraan>[
    Motor('BK 1234 AB', masuk),
    Mobil('BK 88 UN', masuk),
    MobilMember('BK 7 MIPA', masuk),
  ];

  for (final k in daftar) {
    final bayar = k.biaya(masuk.add(const Duration(hours: 3)));
    print('KELUAR $k bayar Rp$bayar');
  }
}