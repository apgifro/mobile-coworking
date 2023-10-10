import 'package:coworking/model/resource.dart';

class Room {
  String id;
  String name;
  int number;
  int people;
  double price;
  bool isActive;
  List<Resource> resources;

  Room({
    required this.id,
    required this.name,
    required this.number,
    required this.people,
    required this.price,
    required this.isActive,
    required this.resources,
  });

}
