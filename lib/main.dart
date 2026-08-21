import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  double? firstOperand;
  String? pendingOperator;
  bool shouldResetDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _displayArea()),
            _buttonGrid(),
          ],
        ),
      ),
    );
  }

  Widget _displayArea() {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.bottomRight,
      child: Text(
        displayText,
        style: const TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buttonGrid() {
    final buttons = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', 'x'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ];

    return Column(
      children: buttons.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((label) {
            return Expanded(child: _buildButton(label));
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: () => _handleButtonPress(label),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: _getButtonColor(label),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Color? _getButtonColor(String label) {
    if (label == 'C') {
      return Colors.redAccent;
    } else if (['+', '-', 'x', '÷'].contains(label)) {
      return Colors.orange;
    } else {
      return Colors.grey[800];
    }
  }

  void _handleButtonPress(String label) {
    if (_isDigit(label)) {
      _onDigitPressed(label);
    } else if (['+', '-', 'x', '÷'].contains(label)) {
      _onOperatorPressed(label);
    } else if (label == 'C') {
      _onClearPress();
    } else if (label == '=') {
      _onEqualPress();
    }
  }

  bool _isDigit(String label) {
    return (label == '0') || (label == '1') || (label == '2') ||
        (label == '3') || (label == '4') || (label == '5') || (label == '6') ||
        (label == '7') || (label == '8') || (label == '9');
  }

  void _onDigitPressed(String digit) {
    setState(() {
      if (shouldResetDisplay) {
        displayText = digit;
        shouldResetDisplay = false;
      } else if (displayText == '0') {
        displayText = digit;
      } else {
        displayText = displayText + digit;
      }
    });
  }

  void _onOperatorPressed(String op) {
    if (pendingOperator != null) {
      _onEqualPress();
    }

    setState(() {
      firstOperand = double.tryParse(displayText);
      pendingOperator = op;
      shouldResetDisplay = true;
    });
  }

  void _onEqualPress() {
    if (pendingOperator == null || firstOperand == null) {
      return;
    }
    double? secondOperand = double.tryParse(displayText);
    if (secondOperand == null) return;

    double result = _compute(firstOperand!, secondOperand, pendingOperator!);

    setState(() {
      displayText = _formatResult(result);
      pendingOperator = null;
      firstOperand = null;
      shouldResetDisplay = true;
    });
  }

  double _compute(double a, double b, String op) {
    switch (op) {
      case '+': return a + b;
      case '-': return a - b;
      case 'x': return a * b;
      case '÷':
        if (b == 0) {
          return double.nan;
        } else {
          return a / b;
        }
      default: return 0;
    }
  }

  String _formatResult(double value) {
    if (value.isNaN) {
      return 'Error';
    }

    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  void _onClearPress() {
    setState(() {
      displayText = '0';
      firstOperand = null;
      pendingOperator = null;
      shouldResetDisplay = false;
    });
  }
}