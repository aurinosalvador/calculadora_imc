import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode = FocusNode();

  String _infoText = 'Informe seus dados!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: _reset,
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /// Imagem
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),

                /// Peso
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _pesoController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu peso';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// Altura
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    controller: _alturaController,
                    decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe sua altura';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// Calcular
                Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _calcular,
                    child: Text('Calcular', textScaleFactor: 1.5),
                  ),
                ),

                /// Resultado
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _reset() {
    _pesoController.text = '';
    _alturaController.text = '';
    _focusNode.requestFocus();
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey.currentState!.reset();
    });
  }

  void _calcular() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      setState(() {
        if (imc < 18.6) {
          _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 18.6 && imc < 24.9) {
          _infoText = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 24.9 && imc < 29.9) {
          _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 29.9 && imc < 34.9) {
          _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 34.9 && imc < 39.9) {
          _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 40) {
          _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
        }
      });
    }
  }
}
