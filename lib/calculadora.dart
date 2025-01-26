import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _display = '0';
  String _operator = '';
  double _firstOperand = 0.0;
  double _secondOperand = 0.0;

  void _inputDigit(String digit) {
    setState(() {
      _display = (_display == '0') ? digit : _display + digit;
    });
  }

  void _inputOperator(String operator) {
    setState(() {
      _firstOperand = double.parse(_display);
      _display = '0';
      _operator = operator;
    });
  }

  void _calculate() {
    setState(() {
      _secondOperand = double.parse(_display);
      switch (_operator) {
        case '+':
          _display = (_firstOperand + _secondOperand).toString();
          break;
        case '-':
          _display = (_firstOperand - _secondOperand).toString();
          break;
        case '*':
          _display = (_firstOperand * _secondOperand).toString();
          break;
        case '/':
          _display = (_firstOperand / _secondOperand).toString();
          break;
      }
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = 0.0;
      _secondOperand = 0.0;
      _operator = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24.0),
              child: Text(
                _display,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ..._buildButtons(),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    List<String> labels = [
      '7', '8', '9', '÷',
      '4', '5', '6', 'x',
      '1', '2', '3', '-',
      '0', '.', '=', '+'
    ];
    return [
      for (int i = 0; i < labels.length; i += 4)
        Row(
          children: [
            for (int j = 0; j < 4; j++)
              _buildButton(labels[i + j]),
          ],
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _clear,
          child: Text(
            'Limpar',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    ];
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (label == 'Limpar') {
            _clear();
          } else if (label == '=') {
            _calculate();
          } else if ('+-x÷'.contains(label)) {
            _inputOperator(label);
          } else {
            _inputDigit(label);
          }
        },
        child: Text(
          label,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
