class IndonesianCity {
  final String name;
  final String province;

  const IndonesianCity(this.name, this.province);
}

/// A curated list of major Indonesian cities/regencies spanning every
/// province, used to drive the Aladhan `timingsByCity` lookup (city +
/// country=Indonesia). Not the full ~514 kabupaten/kota list — that's
/// possible later, but this covers where most users are for v1.
const List<IndonesianCity> indonesianCities = [
  IndonesianCity('Banda Aceh', 'Aceh'),
  IndonesianCity('Medan', 'Sumatera Utara'),
  IndonesianCity('Padang', 'Sumatera Barat'),
  IndonesianCity('Pekanbaru', 'Riau'),
  IndonesianCity('Batam', 'Kepulauan Riau'),
  IndonesianCity('Jambi', 'Jambi'),
  IndonesianCity('Palembang', 'Sumatera Selatan'),
  IndonesianCity('Bengkulu', 'Bengkulu'),
  IndonesianCity('Bandar Lampung', 'Lampung'),
  IndonesianCity('Pangkal Pinang', 'Kepulauan Bangka Belitung'),
  IndonesianCity('Jakarta', 'DKI Jakarta'),
  IndonesianCity('Bogor', 'Jawa Barat'),
  IndonesianCity('Depok', 'Jawa Barat'),
  IndonesianCity('Bekasi', 'Jawa Barat'),
  IndonesianCity('Bandung', 'Jawa Barat'),
  IndonesianCity('Cirebon', 'Jawa Barat'),
  IndonesianCity('Serang', 'Banten'),
  IndonesianCity('Tangerang', 'Banten'),
  IndonesianCity('Semarang', 'Jawa Tengah'),
  IndonesianCity('Surakarta', 'Jawa Tengah'),
  IndonesianCity('Yogyakarta', 'DI Yogyakarta'),
  IndonesianCity('Surabaya', 'Jawa Timur'),
  IndonesianCity('Malang', 'Jawa Timur'),
  IndonesianCity('Denpasar', 'Bali'),
  IndonesianCity('Mataram', 'Nusa Tenggara Barat'),
  IndonesianCity('Kupang', 'Nusa Tenggara Timur'),
  IndonesianCity('Pontianak', 'Kalimantan Barat'),
  IndonesianCity('Palangka Raya', 'Kalimantan Tengah'),
  IndonesianCity('Banjarmasin', 'Kalimantan Selatan'),
  IndonesianCity('Samarinda', 'Kalimantan Timur'),
  IndonesianCity('Tanjung Selor', 'Kalimantan Utara'),
  IndonesianCity('Manado', 'Sulawesi Utara'),
  IndonesianCity('Palu', 'Sulawesi Tengah'),
  IndonesianCity('Makassar', 'Sulawesi Selatan'),
  IndonesianCity('Kendari', 'Sulawesi Tenggara'),
  IndonesianCity('Gorontalo', 'Gorontalo'),
  IndonesianCity('Mamuju', 'Sulawesi Barat'),
  IndonesianCity('Ambon', 'Maluku'),
  IndonesianCity('Ternate', 'Maluku Utara'),
  IndonesianCity('Jayapura', 'Papua'),
  IndonesianCity('Manokwari', 'Papua Barat'),
];
