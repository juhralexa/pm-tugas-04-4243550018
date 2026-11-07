import 'package:pm_tugas_04_4243550018/kendaraan.dart';
import 'package:pm_tugas_04_4243550018/parkiran.dart';

Future<void> main() async {
  final parkiran = Parkiran(3);

  // Layar pos jaga: menampilkan setiap kejadian dari Stream.
  parkiran.kejadian.listen(print);

  final masuk = DateTime(2026, 11, 7, 8);

  // Polimorfisme: satu List<Kendaraan>, banyak jenis.
  final daftar = <Kendaraan>[
    Motor('BK 1234 AB', masuk),
    Mobil('BK 88 UN', masuk),
    MobilMember('BK 7 MIPA', masuk),
  ];

  for (final k in daftar) {
    await parkiran.masuk(k);
  }

  // Kapasitas penuh: kendaraan keempat ditolak.
  try {
    await parkiran.masuk(Truk('BK 999 XY', masuk));
  } on ParkirPenuh catch (e) {
    print('Ditolak: $e');
  }

  // Semua kendaraan parkir 3 jam lalu keluar.
  final keluar = masuk.add(const Duration(hours: 3));
  for (final k in daftar) {
    await parkiran.keluar(k, keluar);
  }

  await parkiran.tutup(); 
  print('Pendapatan: Rp${parkiran.pendapatan}');
}