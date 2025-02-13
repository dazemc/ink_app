import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/home/home_bloc.dart';
import 'package:ink_app/bloc/image_upload/upload_bloc.dart';
import 'package:ink_app/bloc/qr/qr_bloc.dart';
import 'package:ink_app/bloc/weather/weather_bloc.dart';

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
          final stateQR = context.watch<QrBloc>().state;

          if (stateHome is HomeInitial) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black,
                    Colors.grey,
                    Colors.black,
                  ],
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        child: (stateWeather is UpdatingWeather)
                            ? CircularProgressIndicator()
                            : Icon(Icons.cloudy_snowing),
                        onPressed: () => {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(UpdateWeather())
                            }),
                    FloatingActionButton(
                        child: (stateUpload is UploadLoading)
                            ? CircularProgressIndicator()
                            : Icon(Icons.image),
                        onPressed: () => {
                              BlocProvider.of<UploadBloc>(context)
                                  .add(UploadImage())
                            }),
                    FloatingActionButton(
                        child: (stateQR is QrUpdatingWifi)
                            ? CircularProgressIndicator()
                            : Icon(Icons.wifi),
                        onPressed: () =>
                            {BlocProvider.of<QrBloc>(context).add(QrWifi())}),
                    FloatingActionButton(
                        child: (stateQR is QrUpdatingSSH)
                            ? CircularProgressIndicator()
                            : Icon(Icons.password),
                        onPressed: () => {
                              BlocProvider.of<QrBloc>(context).add(QrSSH()),
                            }),
                  ],
                ),
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
          print('QR: $stateQR');
          return Placeholder();
        },
      ),
    );
  }
}
