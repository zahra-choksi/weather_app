import 'dart:convert';

import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/features/data/datasource/remote/weather_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/data/model/weather_model.dart';

import '../../../../core/constants/constants.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource{
  final http.Client client;
  WeatherRemoteDataSourceImpl({
    required this.client
});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async{
   final response = await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

   if(response.statusCode == 200){
     return WeatherModel.fromJson(json.decode(response.body));
   } else {
     throw ServerException();
   }
  }


}