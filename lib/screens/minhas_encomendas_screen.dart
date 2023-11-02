import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/encomenda_model.dart';
import '../widgets/encomenda_widget.dart';

class MinhasEncomendasScreen extends StatelessWidget {
  const MinhasEncomendasScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EncomendaModel>(
      builder: (context, model, child) {
        if (model.encomendas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('lib/assets/imagens/Mailbox-bro.png'),
                const Text(
                  'Você não tem pacotes adicionados.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container( // Adicionado um Container para envolver o ListView
            child: ListView.builder(
              itemCount: model.encomendas.length,
              itemBuilder: (context, index) {
                final encomenda = model.encomendas[index];
                return EncomendaWidget(encomenda: encomenda);
              },
            ),
          );
        }
      },
    );
  }
}
