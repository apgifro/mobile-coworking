import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Todas as salas estão ocupadas.',
      style: TextStyle(fontSize: 17.5),
    ));
  }
}
