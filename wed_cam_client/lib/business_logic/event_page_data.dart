import 'dart:convert';
import 'package:wed_cam_client/business_logic/event_data.dart';
import 'package:wed_cam_client/api/base_request.dart';


class EventData {
  List<HostedEvent> hostedEvents = [];
  List<InvitedEvent> invitedEvents = [];
  bool loaded = false;

  getHostedEvents(token, context) async {
    var url = Uri.http(baseUrl, '/api/get_hosted_events');
    await fetchGet(token, url, context).then((response) {
      if (response == null){
        return;
      }
      Iterable list = jsonDecode(utf8.decode(response.bodyBytes))['hosting_events'];
      hostedEvents =
          list.map((model) => HostedEvent.fromJson(model)).toList();
    });
  }

  getInvitedEvents(token, context) async {
    var url = Uri.http(baseUrl, '/api/get_guest_at');
    await fetchGet(token, url, context).then((response) {
      if (response == null){
        return;
      }
      Iterable list = jsonDecode(utf8.decode(response.bodyBytes))['guest_at'];
      invitedEvents =
          list.map((model) => InvitedEvent.fromJson(model)).toList();
    });
  }

  getEverything(token, context) async {
    await getHostedEvents(token, context);
    await getInvitedEvents(token, context);
    loaded = true;
  }

  EventData({token, context}) {
    getEverything(token, context);
  }

  bool isNotEmpty() {
    return loaded;
  }
}
