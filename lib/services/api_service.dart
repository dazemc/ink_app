import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class WeatherUpdate {
  static final url = Uri.parse('http://192.168.0.165:8000/update_weather');
  Future<void> updateWeather() async {
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    print(json);
  }
}

class DisplayUploadImage {
  static final url = Uri.parse('http://192.168.0.165:8000/upload_image');
  late String imagePath;

  Future<void> getImagePicker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePath = pickedFile!.path;
  }

  Future<void> uploadImage() async {
    await getImagePicker();
    final request = http.MultipartRequest('POST', url);
    final multipartFile = await http.MultipartFile.fromPath('file', imagePath);
    request.files.add(multipartFile);
    final response = await request.send();
    print('Image upload attempted: $response');
  }
}
