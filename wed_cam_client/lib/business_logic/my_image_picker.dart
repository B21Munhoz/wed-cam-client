import 'package:image_picker/image_picker.dart';


pickMyImage() async {
  print("app");
  ImagePicker _picker = ImagePicker();

  return await _picker.pickImage(source: ImageSource.gallery,);
}