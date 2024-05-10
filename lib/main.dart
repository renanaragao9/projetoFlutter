import 'package:flutter/material.dart';

void main() => runApp(RenanBank());

class RenanBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[900],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaTransferencia(),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Tranferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: 'Número da Conta',
              dica: '0000',
            ),
            
            Editor(
              controlador: _controladorCampoValor, 
              rotulo: 'Valor', // Nome
              dica: '0.00', // Dica
              icone: Icons.monetization_on, // Icone
            ),
      
            ElevatedButton(
              onPressed: () => criaTrasferencia(context), 
              child: Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }

  void criaTrasferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if(numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  const Editor({super.key, required this.controlador, required this.rotulo, required this.dica, this.icone});

  @override
  Widget build(BuildContext context) { 
    return 
    Padding (
      padding: EdgeInsets.all(16.0),
      
      child: TextField(
        controller: controlador,
        // ignore: prefer_const_constructors
        style: TextStyle(
          fontSize: 24.0
        ),
        
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,  
        ),

        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {

  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
  
}

class ListaTransferenciasState extends State<ListaTransferencia> {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),

      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('Chegou no then do future');
            debugPrint('$transferenciaRecebida');
            if(transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget{

  // ignore: unused_field
  final Transferencia _transferencia;

   ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
} 

class Transferencia {
  final double valor;
  final int numeroConta;
  
  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia(valor: $valor, numeroConta: $numeroConta)';
  }
}
