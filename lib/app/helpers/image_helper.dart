import 'package:image_picker/image_picker.dart';

class ImageHelper {
  Future<String> picker({bool isCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    var response = await picker.pickImage(
      source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );
    if (response != null) {
      return response.path;
    } else {
      return '';
    }
  }
}
