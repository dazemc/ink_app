import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/api_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUpdate weatherUpdateService;

  WeatherBloc(this.weatherUpdateService) : super(WeatherInitial()) {
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
