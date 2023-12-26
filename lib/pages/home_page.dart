import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weaher_app/pages/search_page.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../models/weather_model.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                  // updateUi: updateUi,
                );
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),


      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state)
        {
          if(state is WeatherLoadingState)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is WeatherInitialState)
          {
            return initialBuilder();
          }

          else if(state is WeatherSuccessState)
          {
            // weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return successBuilder(context: context, weatherData: state.weatherModel);
          }

          else
          {
            return const Center(
              child: Text('Some Thing Wont Error'),
            );
          }
        },

      ),




    );
  }



  Widget successBuilder({required BuildContext context, required WeatherModel weatherData}) => Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherData.getThemeColor(),
            weatherData.getThemeColor()[300]!,
            weatherData.getThemeColor()[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
         Text(
          BlocProvider.of<WeatherCubit>(context).cityName!,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'updated at : ${weatherData.date.hour.toString()}:${weatherData!.date.minute.toString()}',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData.getImage()),
              Text(
                weatherData.temp.toInt().toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text('maxTemp :${weatherData.maxTemp.toInt()}'),
                  Text('minTemp : ${weatherData.minTemp.toInt()}'),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          weatherData.weatherStateName,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    ),
  );


  Widget initialBuilder() => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'there is no weather 😔 start',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Text(
          'searching now 🔍',
          style: TextStyle(
            fontSize: 30,
          ),
        )
      ],
    ),
  );
}
