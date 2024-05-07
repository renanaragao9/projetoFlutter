import 'package:flutter/material.dart';

void main() => runApp(RenanBank());

class RenanBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Tranferência'),
      ),
      body: const Column(
        children: <Widget> [
          Padding(
            padding: EdgeInsets.all(16.0),
            
            child: TextField(
              style: TextStyle(
                fontSize: 24.0
              ),
              
              decoration: InputDecoration(
                labelText: 'Número da conta',
                hintText: '0000'
              ),

              keyboardType: TextInputType.number,
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(16.0),
            
            child: TextField(
              style: TextStyle(
                fontSize: 24.0
              ),
              
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Valor',
                hintText: '0.00'
              ),

              keyboardType: TextInputType.number,
            ),
          ),

          ElevatedButton(
            onPressed: null, 
            child: Text('Confirmar'),
          )
        ],
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),

      body: const Column(
        children: <Widget> [
          ItemTransferencia(Transferencia(100.0, 1000)),
          ItemTransferencia(Transferencia(200.0, 1000)),
          ItemTransferencia(Transferencia(400.0, 1000)),
        ],
      ),

      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget{

  // ignore: unused_field
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

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
  const Transferencia(this.valor, this.numeroConta);
}
