import "dart:io";
import 'package:flutter/material.dart';

void main() {
  runApp(const AreaCalculatorApp());
}

class AreaCalculatorApp extends StatelessWidget {
  const AreaCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Área Quadrada',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AreaCalculatorScreen(),
    );
  }
}

class AreaCalculatorScreen extends StatefulWidget {
  const AreaCalculatorScreen({super.key});
  
  @override
  State<AreaCalculatorScreen> createState() => _AreaCalculatorScreenState();
}

class _AreaCalculatorScreenState extends State<AreaCalculatorScreen> {
  // Referencia / identificação para um TextField
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  double? _calculaArea;

  void _calculateArea() {
    if (_widthController.text.isEmpty || _lengthController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, preencha ambos os campos!!")),
      );
      return;
    }

    try {
      // Tratrando dados de decimal BR para USA
      double width = double.parse(_widthController.text.replaceAll(",", "."));

      double length = double.parse(_lengthController.text.replaceAll(",", "."));

      double area = width * length;

      setState(() {
        _calculaArea = area;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Área calculada com sucesso!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Entrada inválida! Use apenas números.")),
      );
    }
  }

  void _selfDestruct() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculadora de Área")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _widthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              // Styles from TextField
              decoration: InputDecoration(
                labelText: "Largura (m)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.width_full_outlined),
              ),
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              // Styles from TextField
              decoration: InputDecoration(
                labelText: "Altura (m)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _calculateArea,
                  child: Text("Calcular"),
                ),
                ElevatedButton(onPressed: _selfDestruct, child: Text("Sair")),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              "Resultado: $_calculaArea",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
