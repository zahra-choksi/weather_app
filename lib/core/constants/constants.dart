class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '915119807f64e7b06b9a81562046522e';
  static String currentWeatherByName (String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'https://openweathermap.org/img/wn/$iconCode@2x.png';

}