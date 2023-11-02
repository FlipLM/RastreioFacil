import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'encomenda.dart';

class EncomendaModel extends ChangeNotifier {
  List<Encomenda> _encomendas = [];

  List<Encomenda> get encomendas => _encomendas;

  EncomendaModel() {
    loadEncomendas();
  }

  void adicionarEncomenda(Encomenda novaEncomenda) {
    _encomendas.add(novaEncomenda);
    saveEncomendas();
    notifyListeners();
  }

  void removerEncomenda(Encomenda encomenda) {
    _encomendas.remove(encomenda);
    saveEncomendas();
    notifyListeners();
  }

  void saveEncomendas() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'encomendas', _encomendas.map((e) => e.toJson()).toList());
  }

  void loadEncomendas() async {
    final prefs = await SharedPreferences.getInstance();
    final encomendasJson = prefs.getStringList('encomendas') ?? [];
    _encomendas = encomendasJson.map((e) => Encomenda.fromJson(e)).toList();
    notifyListeners();
  }
}

