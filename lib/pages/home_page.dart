import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/home/home_bloc.dart';
import 'package:ink_app/bloc/home/home_state.dart';
import 'package:ink_app/bloc/image_upload/upload_bloc.dart';
import 'package:ink_app/bloc/image_upload/upload_event.dart';
import 'package:ink_app/bloc/image_upload/upload_state.dart';
import 'package:ink_app/bloc/weather/weather_bloc.dart';
import 'package:ink_app/bloc/weather/weather_event.dart';
import 'package:ink_app/bloc/weather/weather_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final stateHome = context.watch<HomeBloc>().state;
          final stateWeather = context.watch<WeatherBloc>().state;
          final stateUpload = context.watch<UploadBloc>().state;
          if (stateHome is HomeInitial) {
            print('Home is in initial state');
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      child: (stateWeather is UpdatingWeather)
                          ? CircularProgressIndicator()
                          : Icon(Icons.cloudy_snowing),
                      onPressed: () => {
                            BlocProvider.of<WeatherBloc>(context)
                                .add(UpdateWeather())
                          }),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                      child: (stateUpload is UploadLoading)
                      ? CircularProgressIndicator()
                      : Icon(Icons.image),
                      onPressed: () => {
                            BlocProvider.of<UploadBloc>(context)
                                .add(UploadImage())
                          }),
                ],
              ),
            );
          } else if (stateHome is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (stateWeather is UpdatingWeatherLoaded) {
            // TODO: Learn notifcations and send one.

            BlocProvider.of<WeatherBloc>(context).add(WeatherExit());
          } else if (stateHome is HomeLoaded) {
            return Center(
              child: Text('Done.'),
            );
          }
          print("UNHANDLED STATE:\n");
          print('HOME: $stateHome');
          print('WEATHER: $stateWeather');
          print('UPLOAD: $stateUpload');
          return Placeholder();
        },
      ),
    );
  }
}
