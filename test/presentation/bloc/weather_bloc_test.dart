import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/domain/entity/weather.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/presentation/bloc/weather_state.dart';
import '../../helpers/test_helper.mocks.dart';


void main (){
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
      cityName: 'Province of Turin',
      main: 'Rain',
      description: 'moderate rain',
      iconCode: '10d',
      temperature: 284.2,
      pressure: 1021,
      humidity: 60
  );

  const testCityName = ' Province of Turin';

  test(
      'initial state should be empty',
          () {
        expect(weatherBloc.state, WeatherEmpty());
          });

  blocTest<WeatherBloc,WeatherState>(
  'should emit [weatherLoading . WeatherLoaded] when data is gotten successful',
      build: (){
    when(
        mockGetCurrentWeatherUseCase.execute(testCityName))
        .thenAnswer((_) async => const Right(testWeather) );
    return weatherBloc;
      },
   act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait:  const Duration(milliseconds: 500),
    expect:  () => [
      WeatherLoading(),
      const WeatherLoaded(testWeather)
    ]
  );

  blocTest<WeatherBloc,WeatherState>(
      'should emit [weatherLoading . WeatherLoadFailure] when data is gotten unsuccessful',
      build: (){
        when(
            mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait:  const Duration(milliseconds: 500),
      expect:  () => [
        WeatherLoading(),
        const WeatherLoadFailure('Server Failure')
      ]
  );
}