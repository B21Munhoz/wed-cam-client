import 'package:flutter/services.dart';
import 'package:wed_cam_client/ui/event/confirm_invitation.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';
import 'package:wed_cam_client/ui/utils/others.dart';
import 'package:wed_cam_client/ui/event/event_cards.dart';
import 'package:wed_cam_client/api/base_request.dart';
import 'package:flutter/material.dart';
import 'package:wed_cam_client/business_logic/event_page_data.dart';
import 'dart:async';
import 'package:wed_cam_client/ui/utils/dialogs.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:wed_cam_client/ui/event/create_event.dart';


class EventsPage extends StatefulWidget {
  final isWeb;
  final token;

  EventsPage({
    Key ?key,
    @required this.isWeb,
    @required this.token,
  }) : super(key: key);

  @override
  EventsPageState createState() =>
      new EventsPageState(isWeb: isWeb, token: token);
}


class EventsPageState extends State<EventsPage> {
  final isWeb;
  final token;
  EventsPageState({
    Key ?key,
    @required this.isWeb,
    @required this.token,
  });

  final StreamController<EventData> _streamController =
  new StreamController<EventData>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EventData data = EventData(token: token, context: context);
    _streamController.add(data);

    return StreamBuilder<EventData>(
      stream: _streamController.stream,
      initialData: data,
      builder: (context, snapshot) {
        if (snapshot.data!.loaded) {
          return Container(
            child:
            DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: myTabBar("Casamentos", [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      var url = Uri.http(
                          baseUrl, '/api/logout', {'q': '{http}'});
                      fetchGet(token, url, context);
                      Navigator.pop(context, true);
                    },
                  )
                ], [
                  Tab(text: "Estou Casando",),
                  Tab(text: "Sou Convidado",),
                ]),
                body: TabBarView(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.hostedEvents.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                int count = data.hostedEvents.length;
                                if (index == count) {
                                  var a = true;
                                  return addEventCard((a)async{
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateEvent(
                                            token: token,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        data.getHostedEvents(token, context);
                                      });
                                    },true);
                                } else {
                                  return hostedEventCard(data.hostedEvents[index],
                                    context, token, (i) async {}, (i) async {
                                      var url = Uri.http(
                                          baseUrl, '/api/open_close_event', {'q': '{http}'});
                                      Map map = {
                                        "event_id": data.hostedEvents[index].eventID,
                                      };
                                      var response = await fetchPost(map, token, url, context);
                                      if (response.statusCode == 200){
                                        setState(() {
                                          data.getHostedEvents(token, context);
                                        });
                                      }
                                    },
                                        (i) async {
                                          Clipboard.setData(new ClipboardData(text: data.hostedEvents[index].invitation));
                                          await showStyledToast(
                                            child: Text('Convite Copiado!\nEnvie por texto\npara um Convidado'),
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
                                        },
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.invitedEvents.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                int count = data.invitedEvents.length;
                                if (index == count) {
                                  var a = false;
                                  return addEventCard((a)async{
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ConfirmInvitation(
                                          token: token,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      data.getHostedEvents(token, context);
                                    });
                                  },false);
                                } else {
                                  return guestEventCard(data.invitedEvents[index],
                                    context, token,
                                        (i) async {
                                    },
                                        (i) async {},
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else{
          _streamController.add(data);
          return myLoading();
        }
      }
    );
  }
}


