import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

const String serverURL = 'http://192.168.0.165:8000';

class WeatherUpdate {
  static final url = Uri.parse('$serverURL/update_weather');
  Future<void> updateWeather() async {
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    print(json);
  }
}

class DisplayUploadImage {
  static final url = Uri.parse('$serverURL/upload_image');

  Future<String?> getImagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return (pickedFile != null) ? pickedFile.path : null;
  }

  Future<void> uploadImage() async {
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

class QrCode {
  static final urlWifi = Uri.parse('$serverURL/qr-code/wifi');
  static final urlSSH = Uri.parse('$serverURL/qr-code/ssh');

  Future<void> wifiQR() async {
    final response = await http.get(urlWifi);
    final json = jsonDecode(response.body);
    print(json);
  }

  Future<void> sshQR() async {
    final response = await http.get(urlSSH);
    final json = jsonDecode(response.body);
    print(json);
  }
}

class Quote {
  static final url = Uri.parse('$serverURL/quote');

  Future<void> quoteDisplay() async {
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    print(json);
  }
}
