import '../../model/weather_model.dart';

abstract class WeatherRemoteDataSource {

  Future<WeatherModel> getCurrentWeather (String cityName);

}