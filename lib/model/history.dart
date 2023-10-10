import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking/model/room.dart';

class History {
  String id;
  double price;
  Timestamp startDateTime;
  Timestamp endDateTime;
  Room room;
  String userEmail;

  History({
    required this.id,
    required this.price,
    required this.startDateTime,
    required this.endDateTime,
    required this.room,
    required this.userEmail,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "price": price,
      "startDateTime": startDateTime,
      "endDateTime": endDateTime,
      "room": room.id,
      "userEmail": userEmail,
    };
  }
}
