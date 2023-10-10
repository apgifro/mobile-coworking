import 'package:coworking/controller/history_controller.dart';
import 'package:coworking/controller/room_controller.dart';
import 'package:coworking/controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class ListActiveTileHistory extends StatelessWidget {
  final history;
  final _historyController = Get.put(HistoryController());
  final _timerController = Get.put(TimerController());
  final _roomController = Get.put(RoomController());

  ListActiveTileHistory({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    var startDateTime = history.startDateTime.toDate();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                      '${startDateTime.day.toString().padLeft(2, '0')} de ${DateFormat.MMMM('pt_BR').format(startDateTime)} de ${startDateTime.year}',
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  trailing: Text(
                      r'R$ ' + history.price.toString() + '/h',
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  subtitle: Text(
                      'Entrada às ${startDateTime.hour.toString().padLeft(2, '0')}:${(startDateTime.minute % 60).toString().padLeft(2, '0')}h.'),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                    leading: CircleAvatar(
                      child: Text(history.room.number.toString()),
                    ),
                    title: Text(history.room.name,
                        style: const TextStyle(
                          fontSize: 15,
                        )),
                    trailing: Obx(
                          () => Text(
                          _timerController.getRemainingTime(),
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                    )),
                SizedBox(
                  height: 12,
                ),
                FilledButton.icon(
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
                                    _historyController.activeHistory = history;
                                    _roomController.deactivateRoom();
                                  },
                                  child: const Text('Desativar'),
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text(
                    "Desativar",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
