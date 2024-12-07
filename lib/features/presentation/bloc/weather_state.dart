import 'package:equatable/equatable.dart';
import 'package:weather_app/features/domain/entity/weather.dart';

abstract class WeatherState extends Equatable{
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherEmpty extends WeatherState {}

final class WeatherLoading extends WeatherState{}

final class WeatherLoaded extends WeatherState{
  final WeatherEntity result;
  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

final class WeatherLoadFailure extends WeatherState{
  final String message;
  const WeatherLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
