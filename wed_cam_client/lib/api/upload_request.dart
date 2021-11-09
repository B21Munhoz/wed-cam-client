import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wed_cam_client/api/base_request.dart';


Future uploadImage(var file, String url, String token) async {
  String filename = file.path;
  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Authorization": "Token $token",
    "Content-Type": "application/json; charset=utf-8",
  };

  var uri = Uri.http(baseUrl, url, {'q': '{http}'});
  var request = http.MultipartRequest('POST', uri);
  request.headers.addAll(headers);
  request.files.add(
    http.MultipartFile(
      'image',
      File(filename).readAsBytes().asStream(),
      File(filename).lengthSync(),
      filename: filename.split("/").last
    )
  );
  var res = await request.send();
  return res;
}