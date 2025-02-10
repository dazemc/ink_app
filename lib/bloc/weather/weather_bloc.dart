import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/weather/weather_event.dart';
import 'package:ink_app/bloc/weather/weather_state.dart';
import '../../services/api_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUpdate weatherUpdateService;

  WeatherBloc(this.weatherUpdateService) : super(WeatherInitial()) {
    print('WeatherBloc loaded');
    on<UpdateWeather>((event, emit) async {
      emit(UpdatingWeather());
      try {
        await weatherUpdateService.updateWeather();
      } catch (e) {
        emit(UpdatingWeatherError());
      }
      add(WeatherNotify());
    });

    on<WeatherNotify>((event, emit) async {
      emit(UpdatingWeatherLoaded());
    });

    on<WeatherExit>((event, emit) async {
    });

  }

}
