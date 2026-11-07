abstract class Kendaraan {
  final String plat;
  final DateTime waktuMasuk;

  Kendaraan(this.plat, this.waktuMasuk);

  String get jenis; // abstrak: diisi subclass
  int get tarifPerJam; // abstrak: diisi subclass

  /// Biaya dibulatkan ke atas per jam, minimal 1 jam.
  int biaya(DateTime keluar) {
    var jam = (keluar.difference(waktuMasuk).inMinutes / 60).ceil();
    if (jam < 1) jam = 1;
    return jam * tarifPerJam;
  }

  @override
  String toString() => '$jenis $plat';
}

class Motor extends Kendaraan {
  Motor(super.plat, super.waktuMasuk);

  @override
  String get jenis => 'Motor';
  @override
  int get tarifPerJam => 2000;
}

class Mobil extends Kendaraan {
  Mobil(super.plat, super.waktuMasuk);

  @override
  String get jenis => 'Mobil';
  @override
  int get tarifPerJam => 5000;
}

class Truk extends Kendaraan {
  Truk(super.plat, super.waktuMasuk);

  @override
  String get jenis => 'Truk';
  @override
  int get tarifPerJam => 10000;
}

/// Mixin: diskon 50% untuk pelanggan berlangganan (member).
mixin Berlangganan on Kendaraan {
  @override
  int biaya(DateTime keluar) => super.biaya(keluar) ~/ 2;
}

class MobilMember extends Mobil with Berlangganan {
  MobilMember(super.plat, super.waktuMasuk);

  @override
  String get jenis => 'Mobil (member)';
}