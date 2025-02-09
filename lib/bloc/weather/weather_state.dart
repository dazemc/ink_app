import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class UpdatingWeather extends HomeState {}

class UpdatingWeatherLoaded extends HomeState {}

class UpdatingWeatherError extends HomeState {}