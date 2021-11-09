import 'dart:convert';
import 'package:wed_cam_client/business_logic/event_data.dart';
import 'package:wed_cam_client/api/base_request.dart';


class Photo {
  int photoID = 0;
  String url = "";
  bool approved = false;
  String author = "";

  Photo({
    required this.photoID,
    required this.url,
    required this.approved,
    required this.author,
  });

  factory Photo.fromJson(Map<dynamic, dynamic> json) {
    return Photo(
      photoID: json['photo_id'],
      author: json['author'],
      url: json['url'],
      approved: json['approved'],
    );
  }
}

class ApprovedPhoto {
  int photoID = 0;
  String url = "";
  String author = "";

  ApprovedPhoto({
    required this.photoID,
    required this.url,
    required this.author,
  });

  factory ApprovedPhoto.fromJson(Map<dynamic, dynamic> json) {
    return ApprovedPhoto(
      photoID: json['photo_id'],
      author: json['author'],
      url: json['url'],
    );
  }
}


class PhotoData {
  List<Photo> photos = [];
  bool loaded = false;

  getAllPhotos(token, eventID, context) async {
    var url = Uri.http(baseUrl, '/api/image_list');
    print(eventID);
    await fetchPost({"event_id": eventID}, token, url, context).then((response) {
      if (response == null){
        return;
      }
      Iterable list = jsonDecode(utf8.decode(response.bodyBytes))['photos'];
      photos =
          list.map((model) => Photo.fromJson(model)).toList();
    });
    loaded = true;
    print(loaded);
  }

  PhotoData(token, eventID, {context}) {
    getAllPhotos(token, eventID, context);
  }

  bool isNotEmpty() {
    return loaded;
  }
}

class ApprovedPhotoData {
  List<ApprovedPhoto> photos = [];
  bool loaded = false;

  getAllPhotos(token, eventID, context) async {
    var url = Uri.http(baseUrl, '/api/approved_image_list');
    print(eventID);
    await fetchPost({"event_id": eventID}, token, url, context).then((
        response) {
      if (response == null) {
        return;
      }
      Iterable list = jsonDecode(utf8.decode(response.bodyBytes))['photos'];
      photos =
          list.map((model) => ApprovedPhoto.fromJson(model)).toList();
    });
    loaded = true;
    print(loaded);
  }

  ApprovedPhotoData(token, eventID, {context}) {
    getAllPhotos(token, eventID, context);
  }

  bool isNotEmpty() {
    return loaded;
  }
}