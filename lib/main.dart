//main.dart

import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:rastreios/screens/encomenda.dart';
import 'package:rastreios/screens/encomenda_model.dart';
import 'package:rastreios/screens/formulario_screen.dart';
import 'package:rastreios/screens/minhas_encomendas_screen.dart';
import 'package:rastreios/screens/transportadoras_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EncomendaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rastreio Fácil',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: const Color.fromRGBO(78, 88, 110, 1),
      ),
      home: const MyHomePage(title: 'Rastreio Fácil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Pacotes",
      Colors.grey,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    TabItem(
      Icons.search,
      "Transportadoras",
      Colors.grey,
      labelStyle: const TextStyle(),
    ),
    TabItem(
      Icons.layers,
      "Adicionar",
      Colors.grey,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Consumer<EncomendaModel>(
        builder: (context, model, child) {
          return IndexedStack(
            index: selectedPos,
            children: [
              // Tela principal (Home)
              // Aqui você pode colocar o código da tela principal

              // Tela "Minhas Encomendas"
              const MinhasEncomendasScreen(),
              const TransportadorasScreen(),
              FormularioEncomendaScreen(
                adicionarEncomenda: (Encomenda novaEncomenda) {
                  Provider.of<EncomendaModel>(context, listen: false)
                      .adicionarEncomenda(novaEncomenda);
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }
}