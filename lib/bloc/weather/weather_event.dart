part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class UpdateWeather extends WeatherEvent {}

class WeatherNotify extends WeatherEvent {}

class WeatherExit extends WeatherEvent {}