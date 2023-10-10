import 'package:coworking/view/room/components/list_tile_room.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:coworking/controller/room_controller.dart';

class ListAvailableRoom extends StatelessWidget {
  final _roomController = Get.put(RoomController());

  ListAvailableRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _roomController.getRoom(),
      child: buildListView(),
    );
  }

  buildListView() {
    return Obx(
      () => ListView.separated(
        itemCount: _roomController.availableRooms.length,
        itemBuilder: (BuildContext context, int index) {
          var room = _roomController.availableRooms[index];
          return ListTileRoom(room: room,);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
