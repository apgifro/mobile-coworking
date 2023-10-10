import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class ListInactiveTileHistory extends StatelessWidget {
  final history;
  ListInactiveTileHistory({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    var startDateTime = history.startDateTime.toDate();
    var endDateTime = history.endDateTime.toDate();

    var difference =
        endDateTime.difference(startDateTime).inSeconds;
    var hour = difference ~/ 3600;
    var minute = difference ~/ 60 % 60;
    var second = difference % 60;

    String textTime = '';

    if (hour > 0) {
      textTime += '${hour}h ';
    }

    if (minute > 0) {
      textTime += '${minute} min ';
    }

    textTime += '${second}s';

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
                  trailing:
                  Text(r'R$ ' + history.price.toString(),
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
                  trailing: Text(textTime,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          )),
    );
  }
}
