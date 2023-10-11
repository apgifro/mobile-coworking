import 'package:coworking/controller/google_sign_in_controller.dart';
import 'package:coworking/view/room/components/list_available_room.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:coworking/controller/room_controller.dart';

import 'package:coworking/view/components/empty_list.dart';
import 'package:coworking/view/components/error_list.dart';
import 'package:coworking/view/components/loading_list.dart';

class RoomView extends StatelessWidget {
  final _roomController = Get.put(RoomController());
  final googleSignInController = GoogleSignInController();


  RoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      title: const Text('Salas'),
    );
  }

  buildBody() {
    return Obx(() {
      if (_roomController.state.value == 1) {
        return ListAvailableRoom();
      } else if (_roomController.state.value == 2) {
        return EmptyList();
      } else if (_roomController.state.value == 3) {
        return const ErrorList();
      }
      return const LoadingList();
    });
  }
}
