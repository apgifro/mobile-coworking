import 'package:flutter/material.dart';

class ErrorList extends StatelessWidget {
  const ErrorList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Erro ao carregar.',
        style: TextStyle(fontSize: 17.5),
      ),
    );
  }
}
