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
      debugShowCheckedModeBanner: false, // Desativa a faixa de depuração
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  String _operator = '';
  double _firstOperand = 0.0;
  double _secondOperand = 0.0;

  void _inputDigit(String digit) {
    setState(() {
      if (_display == '0') {
        _display = digit;
      } else {
        _display += digit;
      }
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
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('÷'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('x'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('+'),
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
        ],
      ),
    );
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