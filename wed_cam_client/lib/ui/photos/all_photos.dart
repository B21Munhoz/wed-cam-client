import 'dart:async';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:wed_cam_client/api/base_request.dart';
import 'package:wed_cam_client/business_logic/event_data.dart';
import 'package:wed_cam_client/api/upload_request.dart';
import 'package:wed_cam_client/business_logic/file_list_data.dart';
import 'package:wed_cam_client/ui/utils/dialogs.dart';
import 'package:wed_cam_client/ui/utils/others.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';



class AllPhotosDetails extends StatefulWidget {
  final token;
  final eventID;
  final isWeb;
  final refWidget;
  final album;

  AllPhotosDetails({
    Key ?key,
    @required this.token,
    @required this.eventID,
    @required this.isWeb,
    @required this.refWidget,
    @required this.album,
  }) : super(key: key);

  @override
  AllPhotosDetailsState createState() => AllPhotosDetailsState(
    token: token,
    eventID: eventID,
    isWeb: isWeb,
    refWidget: refWidget,
    album: album,
  );
}

class AllPhotosDetailsState extends State<AllPhotosDetails> {
  final token;
  final eventID;
  final isWeb;
  final refWidget;
  final album;
  var d;


  final StreamController<PhotoData> _streamController =
  new StreamController<PhotoData>();

  final StreamController<ApprovedPhotoData> _streamControllerI =
  new StreamController<ApprovedPhotoData>();

  final formKey = GlobalKey<FormState>();

  AllPhotosDetailsState({
    Key ?key,
    @required this.token,
    @required this.eventID,
    @required this.isWeb,
    @required this.refWidget,
    @required this.album,
  });


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    d = album? ApprovedPhotoData(token, eventID): PhotoData(token, eventID);

    print("InitState AllPhotos");

      return album? StreamBuilder<ApprovedPhotoData>(
          stream: _streamControllerI.stream,
          initialData: d,
          builder: (context, snapshot) {
            if (d.loaded) {
              print("Loaded");
              return Scaffold(
                appBar: myAppBar("Album de Fotos", [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      var url = Uri.http(
                          baseUrl, '/api/logout', {'q': '{http}'});
                      fetchGet(token, url, context);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false);
                    },
                  )
                ],),
                body: Container(
                    color: bgPink,
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(d.photos.length, (index) {
                        return Container(
                        child: Image.network(d.photos[index].url,
                          errorBuilder: (context, error, stackTrace) {
                            print(error);
                            return(Icon(Icons.error));
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                  color: textPink,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!.toInt()
                                  : null,
                            ),
                            );
                          },

                        ),
                        );

                      }),
                    )
                ),
              );
            } else {
              _streamControllerI.add(d);
              return myLoading();
            }
          }):
      StreamBuilder<PhotoData>(
          stream: _streamController.stream,
          initialData: d,
          builder: (context, snapshot) {
            if (d.loaded) {
              print("Loaded");
              return Scaffold(
                appBar: myAppBar("Todas as Fotos", [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      var url = Uri.http(
                          baseUrl, '/api/logout', {'q': '{http}'});
                      fetchGet(token, url, context);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false);
                    },
                  )
                ],),
                body: Container(
                    color: bgPink,
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(d.photos.length, (index) {
                        return GestureDetector(
                          onTap: () async {
                            var res = await fetchPost({
                              "photo_id": d.photos[index].photoID,
                              "event_id": eventID
                            }, token,
                                Uri.http(baseUrl,
                                    '/api/approve_disapprove_image',
                                    {'q': '{http}'})
                                , context);
                            if (res.statusCode == 200){
                              setState(() {
                                d.photos[index].approved = !d.photos[index].approved;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5, color: d.photos[index].approved?
                                goldenYellow: Colors.transparent,
                                )),
                            child: Image.network(d.photos[index].url,
                              errorBuilder: (context, error, stackTrace) {
                                print(error);
                                return(Icon(Icons.error));
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: textPink,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!.toInt()
                                      : null,
                                ),
                                );
                              },

                            ),
                          ),);

                      }),
                    )
                ),
              );
            } else {
              _streamController.add(d);
              return myLoading();
            }
          });
  }
}
