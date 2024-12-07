import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/data/model/weather_model.dart';
import 'package:weather_app/features/data/repository/weather_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/domain/entity/weather.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(remoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
      cityName: 'Province of Turin',
      main: 'Rain',
      description: 'moderate rain',
      iconCode: '10d',
      temperature: 284.2,
      pressure: 1021,
      humidity: 60
  );

  const testWeatherEntity = WeatherEntity(
      cityName: 'Province of Turin',
      main: 'Rain',
      description: 'moderate rain',
      iconCode: '10d',
      temperature: 284.2,
      pressure: 1021,
      humidity: 60
  );

  const testCityName = 'Province of Turin';

  group('get current weather', () {
    test(
        "should return current weather when a call to data source is successful",
            () async {
          // arrange
              when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
                  .thenAnswer((_) async => testWeatherModel);

              // act
              final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

              // assert
              expect(result , equals(const Right(testWeatherEntity)));
            });

    test(
        "should return server failure  when a call to data source is unsuccessful",
            () async {
          // arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(ServerException());

          // act
          final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // assert
          expect(result , equals(const Left(ServerFailure("An error has occurred"))));
        });

    test(
        "should return connection failure  when the device has no internet",
            () async {
          // arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(const SocketException("Failed to connect to the network"));

          // act
          final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // assert
          expect(result , equals(const Left(ConnectionFailure("Failed to connect to the network"))));
        });
  });

}