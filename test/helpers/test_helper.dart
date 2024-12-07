import 'package:http/http.dart' as http ;
import 'package:mockito/annotations.dart';
import 'package:weather_app/features/data/datasource/remote/weather_remote_data_source.dart';
import 'package:weather_app/features/domain/repository/weather_repository.dart';
import 'package:weather_app/features/domain/usecase/get_current_weather.dart';


@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)

void main() {}