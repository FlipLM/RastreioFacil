//transportadoras_screen.dart

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TransportadorasScreen extends StatefulWidget {
  const TransportadorasScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _TransportadorasScreenState createState() => _TransportadorasScreenState();
}

class _TransportadorasScreenState extends State<TransportadorasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Transportadoras:',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: transportadoras.length,
              itemBuilder: (context, index) {
                final transportadora = transportadoras[index];
                return TransportadoraCard(
                  imageUrl: transportadora['imageUrl'] ?? '',
                  name: transportadora['name'] ?? '',
                  transportadoraUrl: transportadora['transportadoraUrl'] ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TransportadoraCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String transportadoraUrl;

  const TransportadoraCard({super.key,
    required this.imageUrl,
    required this.name,
    required this.transportadoraUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(78, 88, 110, 0.8), // Cor do card
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(transportadoraUrl),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Expanded( // Parte superior do card para a imagem
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover, // A imagem cobre toda a parte superior do card
              ),
            ),
            Container( // Parte inferior do card para o nome
              color: const Color.fromRGBO(78, 88, 110, 0.8), // Cor do fundo do container
              width: double.infinity, // Ocupa toda a largura do card
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Padding para o texto
                child: Text(name, style:
                const TextStyle(color:
                Colors.white)), // Cor do texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String transportadoraUrl;

  const WebViewScreen(this.transportadoraUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transportadora'),
      ),
      body: WebView(
        initialUrl: transportadoraUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

final transportadoras = [
  {
    'imageUrl': 'https://t.ctcdn.com.br/OO4DFvvWLOL2Et-eslajieTnr9g=/1200x675/smart/i535351.jpeg',
    'name': 'Correios',
    'transportadoraUrl': 'https://rastreamentocorreios.info/',
  },
  {
    'imageUrl': 'https://www.codecia.com.br/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/l/o/logo_ladlog3.png',
    'name': 'JadLog',
    'transportadoraUrl': 'https://jadlogentregas.com.br/Rastreio',
  },
  {
    'imageUrl': 'https://bravi.tv/wp-content/uploads/2017/10/LOGO-azul-cargos.png',
    'name': 'Azul Cargo',
    'transportadoraUrl': 'https://www.azulcargoexpress.com.br/Rastreio/Rastreio',
  },
  {
    'imageUrl': 'https://ecommercenapratica.com/wp-content/uploads/2021/05/kangu-logo-1024x515.png',
    'name': 'Kangu',
    'transportadoraUrl': 'https://www.kangu.com.br/rastreio/',
  },
  {
    'imageUrl': 'https://agevolution.canalrural.com.br/wp-content/uploads/2019/06/loggi-logo.jpg',
    'name': 'Loggi',
    'transportadoraUrl': 'https://www.loggi.com/rastreador/',
  },
  {
    'imageUrl': 'https://logowik.com/content/uploads/images/511_tnt.jpg',
    'name': 'TNT',
    'transportadoraUrl': 'https://www.ship24.com/pt/correios/tnt-tracking',
  },
];
