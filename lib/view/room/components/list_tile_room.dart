import 'package:coworking/view/room/components/modal_bottom_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileRoom extends StatelessWidget {
  final room;

  late final numberRoom = room!.number.toString();
  late final nameRoom = room!.name;
  late final peopleRoom = room!.people.toString();
  late final priceRoom = r'R$ ' + '${room!.price.toInt()}/h';

  ListTileRoom({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => openBottomSheet(),
      leading: buildLeading(),
      title: buildTitle(),
      subtitle: buildSubtitle(),
      trailing: buildTrailing(),
    );
  }

  openBottomSheet() {
    Get.bottomSheet(
        ModalBottomRoom(
          room: room,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.white);
  }

  buildLeading() {
    return CircleAvatar(
      child: Text(numberRoom),
    );
  }

  buildTitle() {
    return Text(nameRoom);
  }

  buildSubtitle() {
    return Row(
      children: [
        const Icon(Icons.people_outline),
        const SizedBox(
          width: 6,
        ),
        Text(peopleRoom, style: buildTextStyle()),
      ],
    );
  }

  buildTrailing() {
    return Text(priceRoom, style: buildTextStyle());
  }

  buildTextStyle() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400
    );
  }
}
