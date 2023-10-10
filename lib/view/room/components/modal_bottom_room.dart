import 'package:coworking/view/room/components/list_tile_room.dart';
import 'package:flutter/material.dart';

import 'package:coworking/controller/room_controller.dart';

import 'package:get/get.dart';

class ModalBottomRoom extends StatelessWidget {
  final _roomController = Get.put(RoomController());

  final room;
  late final numberRoom = room!.number.toString();
  late final nameRoom = room!.name;
  late final peopleRoom = room!.people.toString();
  late final priceRoom = r'R$ ' + '${room?.price.toInt()}/h';

  ModalBottomRoom({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    var listTileRoom = ListTileRoom(
      room: room,
    );
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 8),
            child: ListTile(
              leading: listTileRoom.buildLeading(),
              title: listTileRoom.buildTitle(),
              subtitle: listTileRoom.buildSubtitle(),
              trailing: listTileRoom.buildTrailing(),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          for (var resource in room!.resources)
            ListTile(
              leading: Text(
                resource.icon,
                style:
                    const TextStyle(fontFamily: 'MaterialIcons', fontSize: 24),
              ),
              title: Text(resource.name),
            ),
          Container(
            height: 20,
          ),
          buildActivateRoomButton(),
        ],
      ),
    );
  }

  buildActivateRoomButton() {
    if (_roomController.activeRoom == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FilledButton.tonalIcon(
            onPressed: () => _roomController.activateRoom(room),
            icon: const Icon(Icons.access_time_outlined),
            label: const Text(
              "Ativar",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FilledButton.tonalIcon(
          onPressed: null,
          icon: const Icon(Icons.access_time_outlined),
          label: const Text(
            "Ativar",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );

  }
}
