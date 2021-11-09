import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:wed_cam_client/api/base_request.dart';
import 'dart:html';



Future<Uint8List> _getHtmlFileContent(blob) async {
  var file;
  final reader = FileReader();
  reader.readAsDataUrl(blob.slice(0, blob.size, blob.type));
  print(6);
  reader.onLoadEnd.listen((event) {
    Uint8List data =
    Base64Decoder().convert(reader.result.toString().split(",").last);
    file = data;
    print("7");
  }).onData((data) {
    file = Base64Decoder().convert(reader.result.toString().split(",").last);
    return file;
  });
  while (file == null) {
    await new Future.delayed(const Duration(milliseconds: 1));
    if (file != null) {
      break;
    }
  }
  return file;
}


Future uploadImage(file, String url, String token) async {
  print("web");

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Authorization": "Token $token",
    "Content-Type": "application/json; charset=utf-8",
  };
  print("1");
  final File xxx = File(file.files.first.bytes, file.files.first.name);
  print("2");
  var uri = Uri.http(baseUrl, url, {'q': '{http}'});
  print("3");
  var request = http.MultipartRequest('POST', uri);
  print("4");
  request.headers.addAll(headers);
  print("5");
  request.files.add(
      http.MultipartFile.fromBytes(
          'image', (await _getHtmlFileContent(xxx)),
          filename: xxx.name));
  var res = await request.send();
  print("8");
  return res;
}