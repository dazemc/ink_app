import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/home/home_bloc.dart';
import 'package:ink_app/bloc/image_upload/upload_bloc.dart';
import 'package:ink_app/bloc/weather/weather_bloc.dart';
import 'package:ink_app/services/api_service.dart';
import 'package:ink_app/pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => WeatherBloc(WeatherUpdate())),
        BlocProvider(create: (BuildContext context) => HomeBloc()),
        BlocProvider(create: (BuildContext context) => UploadBloc(DisplayUploadImage()))
      ],
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          ),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(backgroundColor: Colors.black)),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: SafeArea(child: const HomePage()))));
}
