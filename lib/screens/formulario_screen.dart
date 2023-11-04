//formulario_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../screens/encomenda.dart';
import '../screens/transportadoras_screen.dart';

class FormularioEncomendaScreen extends StatefulWidget {
  final void Function(Encomenda novaEncomenda) adicionarEncomenda;

  const FormularioEncomendaScreen({Key? key, required this.adicionarEncomenda})
      : super(key: key);

  @override
  _FormularioEncomendaScreenState createState() =>
      _FormularioEncomendaScreenState();
}

class _FormularioEncomendaScreenState extends State<FormularioEncomendaScreen> {
  final nomeController = TextEditingController();
  final codigoRastreioController = TextEditingController();
  String transportadoraSelecionada = "Selecione";

  final KeyboardVisibilityController _keyboardVisibilityController =
  KeyboardVisibilityController();

  @override
  void initState() {
    super.initState();

    _keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
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
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromRGBO(79, 88, 110, 1),
            ),
          ),
          const SizedBox(height: 10),
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color.fromRGBO(79, 88, 110, 1),
              textTheme: const TextTheme(
                titleMedium: TextStyle(
                  color: Colors.white54,
                ),
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
                fillColor: Color.fromRGBO(79, 88, 110, 1),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: codigoRastreioController,
            style: const TextStyle(color: Colors.white54),
            decoration: const InputDecoration(
              labelText: 'Código de Rastreamento',
              labelStyle: TextStyle(color: Colors.white54),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromRGBO(79, 88, 110, 1),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final nome = nomeController.text;
              final codigoRastreio = codigoRastreioController.text;

              if (transportadoraSelecionada != "Selecione") {
                final novaEncomenda = Encomenda(
                  nome: nome,
                  transportadora: transportadoraSelecionada,
                  codigoRastreio: codigoRastreio,
                  isExcluindo: false,
                );

                widget.adicionarEncomenda(novaEncomenda);
                FocusScope.of(context).unfocus(); // Fecha o teclado

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sucesso!'),
                      content: const Text('Encomenda adicionada com sucesso!'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Fechar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );



                nomeController.clear();
                codigoRastreioController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Por favor, selecione uma transportadora.')));
              }


            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Adicionar Encomenda'),
          ),
          Image.asset('lib/assets/imagens/Messenger-pana.png', fit: BoxFit.cover),
        ],
      ),
    );
  }
}