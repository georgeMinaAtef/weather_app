
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weaher_app/cubit/state.dart';
import 'package:weaher_app/models/weather_model.dart';
import 'package:weaher_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState>
{
  WeatherCubit(this.weatherService):super(WeatherInitialState());

  WeatherService weatherService;
  String? cityName;
  WeatherModel? weatherModel;

  void getWeather({required String cityName}) async
  {
    emit(WeatherLoadingState());
     try
       {
          weatherModel = await weatherService.getWeather(cityName: cityName);
         emit(WeatherSuccessState(weatherModel: weatherModel!));
       }
     catch(e)
      {
        emit(WeatherFailureState());
      }
  }
}