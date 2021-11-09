import 'dart:async';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:wed_cam_client/api/base_request.dart';
import 'package:wed_cam_client/business_logic/event_data.dart';
import 'package:wed_cam_client/api/upload_request.dart'
if (dart.library.js) 'package:wed_cam_client/api/upload_request_web.dart';
import 'package:wed_cam_client/ui/photos/all_photos.dart';
import 'package:wed_cam_client/business_logic/my_image_picker.dart'
if (dart.library.js) 'package:wed_cam_client/business_logic/my_image_picker_web.dart';
import 'package:wed_cam_client/ui/utils/dialogs.dart';
import 'package:wed_cam_client/ui/utils/others.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';


class EventDetails extends StatefulWidget {
  final token;
  final event;
  final isWeb;
  final refWidget;
  final host;

  EventDetails({
    Key ?key,
    @required this.host,
    @required this.token,
    @required this.event,
    @required this.isWeb,
    @required this.refWidget,
  }) : super(key: key);

  @override
  EventDetailsState createState() => EventDetailsState(
    host: host,
    token: token,
    event: event,
    isWeb: isWeb,
    refWidget: refWidget,
  );
}

class EventDetailsState extends State<EventDetails> {
  final host;
  final token;
  final event;
  final isWeb;
  final refWidget;
  var d;


  final StreamController<HostedEvent> _streamController =
  new StreamController<HostedEvent>();

  final StreamController<InvitedEvent> _streamControllerI =
  new StreamController<InvitedEvent>();

  final formKey = GlobalKey<FormState>();

  EventDetailsState({
    Key ?key,
    @required this.host,
    @required this.token,
    @required this.event,
    @required this.isWeb,
    @required this.refWidget,
  });

  String filename = "";
  ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    d = host? HostedEvent(eventID: event.eventID, eventName: event.eventName,
        eventOpen: event.eventOpen, invitation: event.invitation):
    InvitedEvent(eventID: event.eventID, eventName: event.eventName,
        eventOpen: event.eventOpen);
    print(d.eventID);
    print("EventDetails");
    host? _streamController.add(d): _streamControllerI.add(d);
  }

  @override
  Widget build(BuildContext context) {
    host? _streamController.add(d): _streamControllerI.add(d);
    bool done = true;
    Scaffold s = new Scaffold(
      appBar: myAppBar("${d.eventName}", [
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
      body: SingleChildScrollView(
        child: Container(
          color: bgPink,
          child:  ResponsiveGridRow(
            children: [
              ResponsiveGridCol(
                xs: 6,
                sm: 4,
                md: 3,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      done = false;
                    });
                    var file = isWeb? await pickMyImage() : await pickMyImage();
                    var res = isWeb? await uploadImage(file,
                        '/api/upload/${event.eventID}', token).whenComplete(() => done = true):

                    await uploadImage(file, '/api/upload/${event.eventID}', token,).whenComplete(() => done = true);

                    if (done) {
                      setState(() {});
                      if (res.statusCode == 200) {
                        await showStyledToast(
                          child: Text('Upload Realizado com Sucesso!'),
                          backgroundColor: cardPink,
                          context: context,
                          animationDuration: Duration(milliseconds: 200),
                          duration: Duration(seconds: 4),
                          animationBuilder: (context, animation, child) {
                            return SlideTransition(
                              child: child,
                              position: Tween<Offset>(
                                begin: Offset(0, 1),
                                end: Offset(0, 0),
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.fastOutSlowIn,
                              )),
                            );
                          },
                        );
                      } else {
                        await showStyledToast(
                          child: Text('Erro!'),
                          backgroundColor: cardPink,
                          context: context,
                          animationDuration: Duration(milliseconds: 200),
                          duration: Duration(seconds: 4),
                          animationBuilder: (context, animation, child) {
                            return SlideTransition(
                              child: child,
                              position: Tween<Offset>(
                                begin: Offset(0, 1),
                                end: Offset(0, 0),
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.fastOutSlowIn,
                              )),
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/image_upload.png',
                            height: 150,
                            width: 150,),
                        ),
                        Text("Enviar Imagem")
                      ],
                    ),
                  ),
                ),
              ),
              ResponsiveGridCol(
                xs: 6,
                sm: 4,
                md: 3,
                child: GestureDetector(
                  onTap: () async {
                    print(d.eventID);
                    print("Botão");
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllPhotosDetails(
                          token: token,
                          eventID: d.eventID,
                          isWeb: isWeb,
                          refWidget: refWidget,
                          album: true,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/photo-album2.png',
                            height: 150,
                            width: 150,),
                        ),
                        Text("Álbum Selecionado")
                      ],
                    ),
                  ),
                ),
              ),
              host ? ResponsiveGridCol(
                xs: 6,
                sm: 4,
                md: 3,
                child: GestureDetector(
                  onTap: () async {
                    print(d.eventID);
                    print("Botão");
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllPhotosDetails(
                          token: token,
                          eventID: d.eventID,
                          isWeb: isWeb,
                          refWidget: refWidget,
                          album: false,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/photos.png',
                            height: 150,
                            width: 150,),
                        ),
                        Text("Todas as Fotos")
                      ],
                    ),
                  ),
                ),
              ): ResponsiveGridCol(child: Container()),
              host ? ResponsiveGridCol(
                xs: 6,
                sm: 4,
                md: 3,
                child: GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/guests-book.png',
                            height: 150,
                            width: 150,),
                        ),
                        Text("Convidados")
                      ],
                    ),
                  ),
                ),
              ): ResponsiveGridCol(child: Container()),
            ],
          ),
        ),
      ),
    );

    return host? StreamBuilder<HostedEvent>(
        stream: _streamController.stream,
        initialData: d,
        builder: (context, snapshot) {
          return s;
        }): StreamBuilder<InvitedEvent>(
        stream: _streamControllerI.stream,
        initialData: d,
        builder: (context, snapshot) {
          return s;
        });
  }
}
