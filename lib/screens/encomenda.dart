import 'dart:convert';

class Encomenda {
  final String nome;
  final String transportadora;
  final String codigoRastreio;

  Encomenda(this.nome, this.transportadora, this.codigoRastreio);

  String toJson() => json.encode({
    'nome': nome,
    'transportadora': transportadora,
    'codigoRastreio': codigoRastreio,
  });

  static Encomenda fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return Encomenda(
      jsonData['nome'],
      jsonData['transportadora'],
      jsonData['codigoRastreio'],
    );
  }
}
