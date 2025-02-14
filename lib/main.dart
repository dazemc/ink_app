import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/home/home_bloc.dart';
import 'package:ink_app/bloc/image_upload/upload_bloc.dart';
import 'package:ink_app/bloc/qr/qr_bloc.dart';
import 'package:ink_app/bloc/quote/quote_bloc.dart';
import 'package:ink_app/bloc/weather/weather_bloc.dart';
import 'package:ink_app/services/api_service.dart';
import 'package:ink_app/pages/home_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => WeatherBloc(WeatherUpdate()),
        ),
        BlocProvider(create: (BuildContext context) => HomeBloc()),
        BlocProvider(
          create: (BuildContext context) => UploadBloc(DisplayUploadImage()),
        ),
        BlocProvider(create: (BuildContext context) => QrBloc(QrCode())),
        BlocProvider(create: (BuildContext context) => QuoteBloc()),
      ],
      child: MaterialApp(
        // theme: ThemeData(
        //   brightness: Brightness.light,
        //   primaryColor: Colors.black,
        //   scaffoldBackgroundColor: Colors.grey,
        //   appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        //   floatingActionButtonTheme: FloatingActionButtonThemeData(
        //       backgroundColor: Colors.blueGrey,
        //       foregroundColor: Colors.blueGrey),
        // ),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey,
          appBarTheme: AppBarTheme(backgroundColor: Colors.black),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.grey[700],
            foregroundColor: Colors.white,
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.white,
          ),
        ),
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    ),
  );
}
