import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weaher_app/pages/home_page.dart';
import 'package:weaher_app/services/weather_service.dart';

import 'cubit/cubit.dart';


void main() {
  runApp(BlocProvider(
     create: (context) => WeatherCubit(WeatherService()),
    child: const WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
           backgroundColor: Colors.orange,
          elevation: 0,
        ),
      primarySwatch: BlocProvider.of<WeatherCubit>(context).weatherModel == null ?  Colors.blue : BlocProvider.of<WeatherCubit>(context).weatherModel!.getThemeColor()  ,
      ),
      home: HomePage(),
    );
  }
}
