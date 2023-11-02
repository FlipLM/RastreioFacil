import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucesso'),
      ),
      body: const Center(
        child: Text(
          'Pacote adicionado com sucesso!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
