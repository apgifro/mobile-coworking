import 'package:coworking/controller/navigation_bar_controller.dart';
import 'package:coworking/controller/room_controller.dart';
import 'package:flutter/material.dart';

import 'package:coworking/view/account/account_view.dart';
import 'package:coworking/view/history/history_view.dart';
import 'package:coworking/view/room/room_view.dart';
import 'package:get/get.dart';

import '../../controller/timer_controller.dart';

class NavigationBarView extends StatelessWidget {
  NavigationBarView({Key? key}) : super(key: key);

  final _controller = Get.put(NavigationBarController());
  final _timerController = Get.put(TimerController());
  final _roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: Obx(() => <Widget>[
              RoomView(),
              HistoryView(),
              AccountView(),
            ][_controller.currentIndex.value]),
        bottomNavigationBar: Obx(() => NavigationBar(
              destinations: const <Widget>[
                NavigationDestination(
                    label: 'Salas', icon: Icon(Icons.sensor_door_outlined)),
                NavigationDestination(
                    label: 'Histórico', icon: Icon(Icons.access_time_outlined)),
                NavigationDestination(
                  label: 'Conta',
                  icon: Icon(Icons.person_outline),
                ),
              ],
              selectedIndex: _controller.currentIndex.value,
              onDestinationSelected: (index) {
                _controller.currentIndex.value = index;
              },
            )),
        persistentFooterButtons: _timerController.status.value == true
            ? _showActivateRoomPlayer(context)
            : null));
  }

  _showActivateRoomPlayer(context) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(_roomController.activeRoom!.number.toString()),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  _roomController.activeRoom!.name,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '•',
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(_timerController.getRemainingTime(), style: TextStyle(fontSize: 15),),
              ],
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Desativar?'),
                          content: const Text(
                              'Você seguirá para o pagamento ao desativar.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Voltar'),
                            ),
                            TextButton(
                              onPressed: () {
                                _roomController.deactivateRoom();
                              },
                              child: const Text('Desativar'),
                            ),
                          ],
                        ));
              },
            )
          ],
        ),
      )
    ];
  }
}
