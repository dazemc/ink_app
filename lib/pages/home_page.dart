import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/weather/weather_bloc.dart';
import 'package:ink_app/bloc/weather/weather_event.dart';
import 'package:ink_app/bloc/weather/weather_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            print('Home is in initial state');
            return Center(
              child: FloatingActionButton(
                child: Icon(Icons.cloudy_snowing),
                  onPressed: () =>
                      {BlocProvider.of<HomeBloc>(context).add(UpdateWeather())}),
            );
          } else if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is UpdatingWeather) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Updating weather forecast...'),
                  SizedBox(height: 12,),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (state is UpdatingWeatherLoaded) {

            // TODO: Learn notifcations and send one.

            BlocProvider.of<HomeBloc>(context).add(WeatherExit());
          } else if (state is HomeLoaded) {
            return Center(child: Text('Done.'),);
          }
          print("UNHANDLED STATE: $state");
          return Placeholder();
        },
      ),
    );
  }
}
