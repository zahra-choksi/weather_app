
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecase/get_current_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  WeatherBloc(
      this.getCurrentWeatherUseCase
      ) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result = await getCurrentWeatherUseCase.execute(event.cityName);
      result.fold(
              (l) => emit(WeatherLoadFailure(l.message)),
              (r) => emit(WeatherLoaded(r))
      );
    },
    transformer: debounce(const Duration(milliseconds: 500))
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration){
  return (events,mapper) => events.debounceTime(duration).flatMap(mapper);
}
