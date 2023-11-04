//encomenda_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rastreios/screens/encomenda.dart';
import 'package:provider/provider.dart';
import '../screens/encomenda_model.dart';
import '../screens/transportadoras_screen.dart';


class EncomendaWidget extends StatefulWidget {
  final Encomenda encomenda;

  EncomendaWidget({Key? key, required this.encomenda}) : super(key: key);

  @override
  _EncomendaWidgetState createState() => _EncomendaWidgetState();
}

class _EncomendaWidgetState extends State<EncomendaWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.encomenda.isExcluindo ? 0.0 : 1.0,
      duration: Duration(milliseconds: 500),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5.0,
        child: ListTile(
          contentPadding: const EdgeInsets.all(20.0),
          tileColor: Colors.grey[250],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              widget.encomenda.nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          subtitle: Text(
              'Transportadora: ${widget.encomenda.transportadora}\nCódigo de Rastreio: ${widget.encomenda.codigoRastreio}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.grey),
            onPressed: () {
              setState(() {
                widget.encomenda.isExcluindo = true;
              });
              Future.delayed(Duration(milliseconds: 300), () {
                Provider.of<EncomendaModel>(context, listen: false)
                    .removerEncomenda(widget.encomenda);
              });
            },
          ),
          onTap: () async {
            if (widget.encomenda.isExcluindo) return;
            Clipboard.setData(ClipboardData(text: widget.encomenda.codigoRastreio));
            String? url = transportadoras
                .firstWhere((t) => t['name'] == widget.encomenda.transportadora)['transportadoraUrl'];

            switch (widget.encomenda.transportadora) {
              case "Correios":
                var urlBase = 'https://app.melhorrastreio.com.br/app/correios/';
                url = '$urlBase${widget.encomenda.codigoRastreio}';
                break;
              case "JadLog":
                var urlBase = 'https://app.melhorrastreio.com.br/app/correios/jadlog/';
                url = '$urlBase${widget.encomenda.codigoRastreio}';
                break;
              case "Loggi":
                var urlBase = 'https://app.melhorrastreio.com.br/app/correios/loggi/';
                url = '$urlBase${widget.encomenda.codigoRastreio}';
                break;
            }




            Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url!)));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Código de rastreio copiado!'),
              ),
            );
          },
        ),
      ),
    );
  }
}
