part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class UpdatingWeather extends WeatherState {}

class UpdatingWeatherLoaded extends WeatherState {}

class UpdatingWeatherError extends WeatherState {}
