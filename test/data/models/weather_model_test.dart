import 'dart:convert';

import 'package:weather_app/features/data/model/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/domain/entity/weather.dart';

import '../../helpers/json_reader.dart';

void main (){
  const testWeatherModel = WeatherModel(
      cityName: 'Province of Turin',
      main: 'Rain',
      description: 'moderate rain',
      iconCode: '10d',
      temperature: 284.2,
      pressure: 1021,
      humidity: 60
  );

  test(
      'should be subclass of weather entity ',
          () async {

        // assert
            expect(testWeatherModel, isA<WeatherEntity> ());

          });

  test(
      'should return a valid model from json',
          () async {
        // arrange
            final Map<String,dynamic> jsonMap = json.decode(
              readJson('helpers/dummy_data/dummy_weather_respnse.json')
            );

            // act
            final result = WeatherModel.fromJson(jsonMap);

            // assert
            expect(result, equals(testWeatherModel));

          });

  test (
    'should return a json map containing proper data ',
      () async {
      // act
      final result = testWeatherModel.toJson();

      // assert
        final expectedJsonMap = {
          'weather' : [{
            'main' : 'Rain',
            'description' : 'moderate rain',
            'icon' : '10d',
          }],
          'main' : {
            'temp': 284.2,
            'pressure' :1021,
            'humidity' :60,
          },
          'name':'Province of Turin'
        };
         expect(result, equals(expectedJsonMap));
      }
  );


}