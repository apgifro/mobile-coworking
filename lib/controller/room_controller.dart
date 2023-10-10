import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking/controller/history_controller.dart';
import 'package:coworking/controller/navigation_bar_controller.dart';
import 'package:coworking/controller/timer_controller.dart';
import 'package:coworking/model/resource.dart';
import 'package:get/get.dart';

import '../model/room.dart';

class RoomController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  var availableRooms = <Room>[].obs;
  var state = 0.obs;
  Room? activeRoom;
  var currentRoomIndex = 0;

  final _navigationController = Get.put(NavigationBarController());
  final _timerController = Get.put(TimerController());

  @override
  void onInit() {
    super.onInit();
    getRoom();
  }

  getOneRoom(String roomId) async {
    Room? room;
    await _firestore.collection("room").doc(roomId).get().then(
      (DocumentSnapshot docSnapshot) {
        var id = docSnapshot.id;
        var data = docSnapshot.data() as Map<String, dynamic>;
        var isActiveRoom = data['isActive'];

        var nameRoom = data['name'];
        var numberRoom = data['number'].toInt();
        var peopleRoom = data['people'].toInt();
        var priceRoom = data['price'].toDouble();

        List<Resource> listResources = [];
        var resourcesRoom = data['resources'];
        for (final list in resourcesRoom) {
          var resourceName = list['resource'];
          var resourceIcon = list['icon'];
          var resource = Resource(name: resourceName, icon: resourceIcon);
          listResources.add(resource);
        }

        room = Room(
            id: id,
            name: nameRoom,
            number: numberRoom,
            people: peopleRoom,
            price: priceRoom,
            isActive: isActiveRoom,
            resources: [...listResources]);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return room;
  }

  getRoom() async {
    List<Room> listRooms = [];

    await _firestore.collection("room").orderBy("number").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var id = docSnapshot.id;
          var data = docSnapshot.data();
          var isActiveRoom = data['isActive'];
          if (isActiveRoom) {
            continue;
          }
          var nameRoom = data['name'];
          var numberRoom = data['number'].toInt();
          var peopleRoom = data['people'].toInt();
          var priceRoom = data['price'].toDouble();

          List<Resource> listResources = [];
          var resourcesRoom = data['resources'];
          for (final list in resourcesRoom) {
            var resourceName = list['resource'];
            var resourceIcon = list['icon'];
            var resource = Resource(name: resourceName, icon: resourceIcon);
            listResources.add(resource);
          }

          var room = Room(
              id: id,
              name: nameRoom,
              number: numberRoom,
              people: peopleRoom,
              price: priceRoom,
              isActive: isActiveRoom,
              resources: [...listResources]);
          listRooms.add(room);
        }
      },
      onError: (e) => {state.value = 3},
    );
    availableRooms.assignAll(listRooms);
    if (availableRooms.isEmpty) {
      state.value = 2;
    }
    state.value = 1;
  }

  activateRoom(room) {
    final _history_controller = Get.put(HistoryController());
    activeRoom = room;
    _history_controller.createHistory();
    _history_controller.state.value = 0;
    _history_controller.getHistory();
    _timerController.startTimer();
    getRoom();
    Get.back();
    _navigationController.currentIndex.value = 1;
  }

  deactivateRoom() {
    final _historyController = Get.put(HistoryController());
    _timerController.stopTimer();
    _historyController.updateHistory();
    activeRoom = null;
    _historyController.getHistory();
    Get.back();
    getRoom();
  }
}
