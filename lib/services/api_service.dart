import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:ink_app/services/mdns.dart';

class ServerConfig {
  static Future<String> get serverUrl async {
    final addr = await getmDnsAddr() ?? '0.0.0.0';
    return 'http://$addr:8000';
  }
}

class WeatherUpdate extends ServerConfig {
  late final String _serverUrl;

  Future<void> init() async {
    _serverUrl = await ServerConfig.serverUrl;
  }

  Future<void> updateWeather() async {
    await init();
    final url = Uri.parse('$_serverUrl/update_weather');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    print(json);
  }
}

class DisplayUploadImage extends ServerConfig {
  late final String _serverUrl;
  Future<void> init() async {
    _serverUrl = await ServerConfig.serverUrl;
  }

  Future<String?> getImagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return (pickedFile != null) ? pickedFile.path : null;
  }

  Future<void> uploadImage() async {
    await init();
    final url = Uri.parse('$_serverUrl/upload_image');

    final imagePath = await getImagePicker();
    if (imagePath != null) {
      final request = http.MultipartRequest('POST', url);
      final multipartFile = await http.MultipartFile.fromPath(
        'file',
        imagePath,
      );
      request.files.add(multipartFile);
      final response = await request.send();
      print('Image upload attempted: $response');
    }
  }
}

class QrCode extends ServerConfig {
  late final String _serverUrl;

  Future<void> init() async {
    _serverUrl = await ServerConfig.serverUrl;
  }

  Future<void> wifiQR() async {
    await init();
    final urlWifi = Uri.parse('$_serverUrl/qr-code/wifi');
    final response = await http.get(urlWifi);
    final json = jsonDecode(response.body);
    print(json);
  }

  Future<void> sshQR() async {
    await init();
    final urlSSH = Uri.parse('$_serverUrl/qr-code/ssh');
    final response = await http.get(urlSSH);
    final json = jsonDecode(response.body);
    print(json);
  }
}

class Quote extends ServerConfig {
  late final String _serverUrl;
  Future<void> init() async {
    _serverUrl = await ServerConfig.serverUrl;
  }

  Future<void> quoteDisplay() async {
    final url = Uri.parse('$_serverUrl/quote');
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    print(json);
  }
}
