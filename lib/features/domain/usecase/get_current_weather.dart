import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/domain/entity/weather.dart';
import 'package:weather_app/features/domain/repository/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository repository;
  GetCurrentWeatherUseCase(this.repository);

  Future<Either<Failure,WeatherEntity>> execute(String cityName){
    return repository.getCurrentWeather(cityName);
  }
}