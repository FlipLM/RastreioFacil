// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/encomenda.dart';
import '../screens/encomenda_model.dart';
import '../screens/transportadoras_screen.dart';

class FormularioEncomendaScreen extends StatefulWidget {
  const FormularioEncomendaScreen(
      void Function(Encomenda novaEncomenda) adicionarEncomenda,
      {super.key});

  @override
  _FormularioEncomendaScreenState createState() =>
      _FormularioEncomendaScreenState();
}

class _FormularioEncomendaScreenState extends State<FormularioEncomendaScreen> {
  final nomeController = TextEditingController();
  final codigoRastreioController = TextEditingController();
  String transportadoraSelecionada = "Selecione";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Adicionar Pacotes:',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            TextField(
              controller: nomeController,
              style: const TextStyle(color: Colors.white54),
              decoration: const InputDecoration(
                labelText: 'Nome da Encomenda',
                labelStyle: TextStyle(color: Colors.white54),
                // Cor do placeholder
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromRGBO(79, 88, 110, 1),
              ),
            ),
            const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color.fromRGBO(79, 88, 110, 1),
                // Cor de fundo do dropdown
                textTheme: const TextTheme(
                  titleMedium: TextStyle(
                      color: Colors.white54), // Cor do texto do dropdown
                ),
              ),
              child: DropdownButtonFormField<String>(
                value: transportadoraSelecionada,
                onChanged: (String? newValue) {
                  setState(() {
                    transportadoraSelecionada = newValue!;
                  });
                },
                items: ["Selecione", ...transportadoras.map((t) => t['name'])]
                    .map((transportadora) {
                  return DropdownMenuItem<String>(
                    value: transportadora,
                    child: Text(transportadora!),
                  );
                }).toList(),
                decoration: const InputDecoration(
                    labelText: 'Transportadora',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromRGBO(79, 88, 110, 1)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: codigoRastreioController,
              style: const TextStyle(color: Colors.white54),
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white54),
                  labelText: 'Código de Rastreamento',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromRGBO(79, 88, 110, 1)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final nome = nomeController.text;
                final codigoRastreio = codigoRastreioController.text;

                if (transportadoraSelecionada != "Selecione") {
                  final novaEncomenda = Encomenda(
                    nome,
                    transportadoraSelecionada,
                    codigoRastreio,
                  );

                  Provider.of<EncomendaModel>(context, listen: false)
                      .adicionarEncomenda(novaEncomenda);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sucesso!'),
                        content:
                            const Text('Encomenda adicionada com sucesso!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Fechar'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Fecha o pop-up
                            },
                          ),
                        ],
                      );
                    },
                  );

                  // Limpa os campos do formulário após a adição da encomenda
                  nomeController.clear();
                  codigoRastreioController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Por favor, selecione uma transportadora.')));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text('Adicionar Encomenda'),
            ),
            Expanded(child: Image.asset('lib/assets/imagens/Messenger-pana.png', fit: BoxFit.cover))
          ],
        ),
      ),
    );
  }
}
