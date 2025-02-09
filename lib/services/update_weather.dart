import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherUpdate {
  final url = Uri.parse('http://192.168.0.165:8000/update_weather');
  Future<void> updateWeather() async {
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    print(json);
  }
}
