import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rastreios/screens/encomenda.dart';
import 'package:provider/provider.dart';
import '../screens/encomenda_model.dart';
import '../screens/transportadoras_screen.dart';

class EncomendaWidget extends StatelessWidget {
  final Encomenda encomenda;

  const EncomendaWidget({super.key, required this.encomenda});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          tileColor: Colors.grey[200],
          title:
          Text(encomenda.nome, style:
          const TextStyle(fontWeight:
          FontWeight.bold, fontSize:
          18.0)),
          subtitle:
          Text('Transportadora: ${encomenda.transportadora}\nCódigo de Rastreio: ${encomenda.codigoRastreio}'),
              trailing:
              IconButton(icon:
              const Icon(Icons.delete, color:
              Colors.red), onPressed:
          () {
        Provider.of<EncomendaModel>(context, listen:
        false).removerEncomenda(encomenda);
      }),
      onTap: () async {
        Clipboard.setData(ClipboardData(text:
        encomenda.codigoRastreio));
        String? url =
        transportadoras.firstWhere((t) =>
        t['name'] ==
            encomenda.transportadora)['transportadoraUrl'];
        Navigator.push(context, MaterialPageRoute(builder:
            (context) =>
            WebViewScreen(url!)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código de rastreio copiado!'),
          ),
        );
      },
    ),
    );
  }
}
