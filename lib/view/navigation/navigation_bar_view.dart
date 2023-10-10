import 'package:coworking/controller/navigation_bar_controller.dart';
import 'package:flutter/material.dart';

import 'package:coworking/view/account/account_view.dart';
import 'package:coworking/view/history/history_view.dart';
import 'package:coworking/view/room/room_view.dart';
import 'package:get/get.dart';


class NavigationBarView extends StatelessWidget {
  NavigationBarView({Key? key}) : super(key: key);

  final _controller = Get.put(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              label: 'Reservas', icon: Icon(Icons.access_time_outlined)),
          NavigationDestination(
            label: 'Conta',
            icon: Icon(Icons.person_outline),
          ),
        ],
        selectedIndex: _controller.currentIndex.value,
        onDestinationSelected: (index) { _controller.currentIndex.value = index; },
      )),
    );
  }
}
