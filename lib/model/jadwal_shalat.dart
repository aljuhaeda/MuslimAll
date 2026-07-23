class JadwalShalat {
  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;

  JadwalShalat({
    this.tanggal,
    this.imsak,
    this.subuh,
    this.terbit,
    this.dzuhur,
    this.ashar,
    this.maghrib,
    this.isya,
  });

  // Parses the Aladhan API's timingsByCity response
  // (https://api.aladhan.com/v1/timingsByCity?city=..&country=Indonesia&method=20).
  factory JadwalShalat.fromAladhan(Map<String, dynamic> json) {
    final data = json['data'];
    final timings = data['timings'];
    return JadwalShalat(
      tanggal: data['date']?['readable'],
      imsak: timings['Imsak'],
      subuh: timings['Fajr'],
      terbit: timings['Sunrise'],
      dzuhur: timings['Dhuhr'],
      ashar: timings['Asr'],
      maghrib: timings['Maghrib'],
      isya: timings['Isha'],
    );
  }
}
