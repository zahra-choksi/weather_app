import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/data/datasource/remote/weather_remote_data_source.dart';
import 'package:weather_app/features/data/datasource/remote/weather_remote_data_source_impl.dart';
import 'package:weather_app/features/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/domain/repository/weather_repository.dart';
import 'package:weather_app/features/domain/usecase/get_current_weather.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

void setUpLocator () {

  // bloc
  sl.registerFactory(() => WeatherBloc(sl()));

  //use case
  sl.registerLazySingleton(() => GetCurrentWeatherUseCase(sl()));

  // repository

  sl.registerLazySingleton<WeatherRepository>
    (() => WeatherRepositoryImpl(
      remoteDataSource: sl()) );

  // data source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
          () => WeatherRemoteDataSourceImpl(
              client: sl()) );

  // external
  sl.registerLazySingleton(() => http.Client());


}