import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/indonesia_cities.dart';
import '../model/jadwal_shalat.dart';

const _prefsKeyCity = 'selected_city';
const _defaultCity = 'Jakarta';

class TimesController extends GetxController {
  var isFetching = false.obs;
  var errorMessage = ''.obs;
  var selectedCity = _defaultCity.obs;
  JadwalShalat? jadwalShalat;

  @override
  void onInit() {
    super.onInit();
    _loadCityAndFetch();
  }

  Future<void> _loadCityAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    selectedCity.value = prefs.getString(_prefsKeyCity) ?? _defaultCity;
    await fetchData();
  }

  Future<void> setCity(String city) async {
    selectedCity.value = city;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyCity, city);
    await fetchData();
  }

  Future<void> fetchData() async {
    isFetching.value = true;
    errorMessage.value = '';
    try {
      jadwalShalat = await _getJadwalShalat(selectedCity.value);
    } catch (e) {
      errorMessage.value = 'Gagal memuat data. Periksa koneksi internet Anda.';
    } finally {
      isFetching.value = false;
    }
  }

  // Kemenag RI (Indonesian Ministry of Religious Affairs) calculation
  // method, resolved by city name across all of Indonesia (not just Malang).
  Future<JadwalShalat> _getJadwalShalat(String city) async {
    final now = DateTime.now();
    final formattedDate =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    final dio = Dio();
    final res = await dio.get(
      "https://api.aladhan.com/v1/timingsByCity/$formattedDate",
      queryParameters: {
        'city': city,
        'country': 'Indonesia',
        'method': 20,
      },
    );
    return JadwalShalat.fromAladhan(res.data);
  }

  List<String> get cityNames => indonesianCities.map((c) => c.name).toList();
}
