import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/presentation/pages/weather_page.dart';
import 'package:weather_app/injection_container.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(_) => sl<WeatherBloc>() )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather app',
          home: WeatherPage()
      ),
    );
  }
}
