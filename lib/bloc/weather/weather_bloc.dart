import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/weather/weather_event.dart';
import 'package:ink_app/bloc/weather/weather_state.dart';
import '../../services/update_weather.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherUpdate weatherUpdateService;

  HomeBloc(this.weatherUpdateService) : super(HomeInitial()) {
    print('HomeBloc loaded');
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
      emit(HomeLoaded());
    });

  }

}
