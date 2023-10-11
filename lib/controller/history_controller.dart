import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking/controller/room_controller.dart';
import 'package:coworking/controller/timer_controller.dart';
import 'package:coworking/model/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  var availableHistory = <History>[].obs;
  var state = 0.obs;

  History? activeHistory;

  final _controller = Get.put(RoomController());
  final _timer_controller = Get.put(TimerController());

  @override
  void onInit() {
    super.onInit();
    getHistory();
  }

  createHistory() async {
    final roomActive =
        _firestore.collection("room").doc(_controller.activeRoom!.id);
    roomActive.update({"isActive": true}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));

    var userEmail = FirebaseAuth.instance.currentUser?.email;

    activeHistory = History(
      id: '',
      price: _controller.activeRoom!.price,
      startDateTime: Timestamp.now(),
      endDateTime: Timestamp.now(),
      room: _controller.activeRoom!,
      userEmail: userEmail!,
    );

    var document = _firestore.collection("history").add(activeHistory!.toFirestore());
    document.then((value) {
      activeHistory!.id = value.id;
    });
  }

  updateHistory() async {
    final roomInactive =
        _firestore.collection("room").doc(_controller.activeRoom!.id);
    roomInactive.update({"isActive": false}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));

    activeHistory!.endDateTime = Timestamp.now();
    var timeInRoom = _timer_controller.remainingTime.value;
    var priceRoom = _controller.activeRoom!.price;
    var costRoom = timeInRoom * priceRoom / 60 / 60;
    print(priceRoom);
    print(timeInRoom);
    print(costRoom);
    activeHistory!.price = double.parse(costRoom.toStringAsFixed(2));
    print(activeHistory!.price);

    final deactivateRoom =
        _firestore.collection("history").doc(activeHistory!.id);
    deactivateRoom.update(activeHistory!.toFirestore()).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  getHistory() async {
    List<History> listHistory = [];

    var userEmail = FirebaseAuth.instance.currentUser?.email;

    await _firestore
        .collection("history")
        .where('userEmail', isEqualTo: userEmail)
        .orderBy("startDateTime", descending: true)
        .get()
        .then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          var id = docSnapshot.id;
          var data = docSnapshot.data();

          var priceHistory = data['price'].toDouble();
          var startDateTime = data['startDateTime'];
          var endDateTime = data['endDateTime'];
          var room = data['room'];

          room = await _controller.getOneRoom(room);

          var history = History(
            id: id,
            price: priceHistory,
            startDateTime: startDateTime,
            endDateTime: endDateTime,
            room: room,
            userEmail: userEmail!,
          );
          listHistory.add(history);
        }
      },
      onError: (e) => {state.value = 3},
    );
    availableHistory.assignAll(listHistory);
    state.value = 1;
    if (availableHistory.isEmpty) {
      state.value = 2;
    }
  }
}
