import 'dart:html' as webFile;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';


pickMyImage() async{
  print("web");
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','jpeg','gif']);
  if (result != null) {
    return result;
  }
}
