import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/home/home_event.dart';
import 'package:ink_app/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeInitial()) {
    on<HomeReady>((event, emit) async {
      
    });
  }
  

}