import 'package:flutter/material.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wed_cam_client/business_logic/event_data.dart';


Widget addEventCard(Future<Null> onTapFunction(bool b), bool opt) {
  Card c = Card(
    elevation: 5,
    color: cardPink,
    child: ListTile(
      onTap: (()=>onTapFunction(opt)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add_circle,
            color: textPink,
          ),
          Text("  "),
          Expanded(
            child: Text((opt == true)?
              "Criar Casamento":"Confirmar Presença",
//                                                overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  return c;
}

Widget hostedEventCard(
    HostedEvent d,
    context,
    token,
    Future<Null> onTapFunction(int d),
    Future<Null> openCloseEvent(int i),
    Future<Null> sendInvite(int i)) {
  Slidable s = new Slidable(
    child: Card(
      color: Colors.white,
      elevation: 5,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                onTap: (() => onTapFunction(d.eventID)),
                leading: Image.asset('images/wedding-rings.png',
                  height: 42,
                  width: 42,),
                title: Text(
                  "${d.eventName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  d.eventOpen?"Começou o Casório!":"Não Começou",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.drag_indicator,
              )
            ),
          ],
        ),
      ),
    ),

    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.20,
    secondaryActions: <Widget>[
      SlideAction(
        onTap: (() => openCloseEvent(d.eventID)),
        child: CircleAvatar(
          child: Icon(
            d.eventOpen? Icons.lock_open: Icons.lock_outline,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: d.eventOpen? Colors.green: Colors.red,
          radius: 30,
        ),
      ),
      SlideAction(
        onTap: (() => sendInvite(d.eventID)),
        child: CircleAvatar(
          child: Text("Convite", style: TextStyle(color: Colors.white),),
          backgroundColor: goldenYellow,
          radius: 30,
        ),
      ),
    ],
  );
  return s;
}

Widget guestEventCard(
    InvitedEvent d,
    context,
    token,
    Future<Null> onTapFunction(int d),
    Future<Null> openCloseEvent(int i)) {
  Card c = new Card(
      color: Colors.white,
      elevation: 5,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                onTap: (() => onTapFunction(d.eventID)),
                leading: Image.asset('images/wedding-day.png',
                  height: 42,
                  width: 42,),
                title: Text(
                  "${d.eventName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  d.eventOpen?"Começou o Casório!":"Não Começou",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  return c;
}