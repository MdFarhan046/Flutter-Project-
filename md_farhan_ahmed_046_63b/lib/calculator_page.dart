import 'package:flutter/material.dart';
import 'package:md_farhan_ahmed_046_63b/widget/input_field.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double result = 0;

  void add() {
    double n1 = double.parse(num1Controller.text);
    double n2 = double.parse(num2Controller.text);

    setState(() {
      result = n1 + n2;
    });
  }

  void subtract() {
    double n1 = double.parse(num1Controller.text);
    double n2 = double.parse(num2Controller.text);

    setState(() {
      result = n1 - n2;
    });
  }

  void multiply() {
    double n1 = double.parse(num1Controller.text);
    double n2 = double.parse(num2Controller.text);

    setState(() {
      result = n1 * n2;
    });
  }

  void divide() {
    double n1 = double.parse(num1Controller.text);
    double n2 = double.parse(num2Controller.text);

    setState(() {
      result = n1 / n2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text("Calculator")
        ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                controller: num1Controller,
                obsecureText: false,
                keyboardType: TextInputType.number,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is empty";
                  } else if (!RegExp(r'^\d+\.\d+$').hasMatch(value)) {
                    return "Enter valid number";
                  }

                  return null;
                },
                labelText: "First Number",
                hintText: "Enter Number",
                prefixIcon: Icon(Icons.calculate),
              ),
              const SizedBox(height: 15),
              InputField(
                controller: num2Controller,
                obsecureText: false,
                keyboardType: TextInputType.number,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is empty";
                  } else if (!RegExp(r'^\d+\.\d+$').hasMatch(value)) {
                    return "Enter valid number";
                  }

                  return null;
                },
                labelText: "Second Number",
                hintText: "Enter Number",
                prefixIcon: Icon(Icons.calculate),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: add,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: subtract,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "-",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: multiply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "×",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: divide,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "÷",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Result: $result",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
