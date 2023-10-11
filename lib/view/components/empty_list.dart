import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/empty.png'),
            const Text('Tudo tão vazio por aqui...', style: TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
