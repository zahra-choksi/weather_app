import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/data/datasource/remote/weather_remote_data_source.dart';
import 'package:weather_app/features/domain/entity/weather.dart';
import 'package:weather_app/features/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  WeatherRepositoryImpl({
    required this.remoteDataSource
});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName)async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occurred"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }

  }


}