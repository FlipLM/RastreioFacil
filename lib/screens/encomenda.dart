//encomenda.dart

import 'dart:convert';

class Encomenda {
  final String nome;
  final String transportadora;
  final String codigoRastreio;
  bool isExcluindo;

  Encomenda({
    required this.nome,
    required this.transportadora,
    required this.codigoRastreio,
    required this.isExcluindo,
  });


  String toJson() => json.encode({
    'nome': nome,
    'transportadora': transportadora,
    'codigoRastreio': codigoRastreio,
    'isExcluindo': isExcluindo,
  });

  static Encomenda fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return Encomenda(
      nome: jsonData['nome'],
      transportadora: jsonData['transportadora'],
      codigoRastreio: jsonData['codigoRastreio'],
      isExcluindo: jsonData['isExcluindo'],
    );
  }
}
