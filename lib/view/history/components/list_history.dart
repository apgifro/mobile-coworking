import 'package:coworking/controller/history_controller.dart';
import 'package:coworking/controller/timer_controller.dart';
import 'package:coworking/view/history/components/list_inactive_tile_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListHistory extends StatelessWidget {
  final _historyController = Get.put(HistoryController());

  ListHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          _historyController.getHistory();
        },
        child: buildHistory(),
    );
  }

  buildHistory() {
    return Obx(
          () => ListView.separated(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: _historyController.availableHistory.length,
            itemBuilder: (BuildContext context, int index) {
              var history = _historyController.availableHistory[index];
                return ListInactiveTileHistory(history: history);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            // BUG show TIMER
          ),
    );
  }
}
