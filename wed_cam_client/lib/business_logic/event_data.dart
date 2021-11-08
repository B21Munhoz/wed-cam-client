class HostedEvent {
  int eventID = 0;
  String eventName = "";
  bool eventOpen = false;
  String invitation = "";

  HostedEvent({
    required this.eventID,
    required this.eventName,
    required this.eventOpen,
    required this.invitation,
  });

  factory HostedEvent.fromJson(Map<dynamic, dynamic> json) {
    return HostedEvent(
      eventID: json['event_id'],
      eventName: json['event_name'],
      eventOpen: json['event_open'],
      invitation: json['invitation'],
    );
  }
}


class InvitedEvent {
  int eventID = 0;
  String eventName = "";
  bool eventOpen = false;

  InvitedEvent({
    required this.eventID,
    required this.eventName,
    required this.eventOpen,
  });

  factory InvitedEvent.fromJson(Map<dynamic, dynamic> json) {
    return InvitedEvent(
      eventID: json['event_id'],
      eventName: json['event_name'],
      eventOpen: json['event_open'],
    );
  }
}