import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/history_controller.dart';
import '../components/empty_list.dart';
import '../components/error_list.dart';
import '../components/loading_list.dart';
import 'components/list_history.dart';


class HistoryView extends StatelessWidget {

  final _controller = Get.put(HistoryController());

  HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      title: const Text('Histórico'),
    );
  }

  buildBody() {
    return Obx(() {
      if (_controller.state.value == 1) {
        return ListHistory();
      } else if (_controller.state.value == 2) {
        return EmptyList();
      } else if (_controller.state.value == 3) {
        return const ErrorList();
      }
      return const LoadingList();
    });
  }
}
