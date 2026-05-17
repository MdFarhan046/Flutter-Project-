import 'package:flutter/material.dart';
import 'package:md_farhan_ahmed_046_63b/widget/input_field.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double bmi = 0;
  String status = "";

  void calculateBMI() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);

    height = height / 100;

    setState(() {
      bmi = weight / (height * height);

      if (bmi < 18.5) {
        status = "Underweight";
      } else if (bmi < 25) {
        status = "Normal";
      } else {
        status = "Overweight";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("BMI Calculator")),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          children: [
            InputField(
              controller: weightController,
              obsecureText: false,
              keyboardType: TextInputType.number,
            
              validator: (value){

              },
               labelText: "Enter your Weight (kg)",
               hintText: "Weight",
               prefixIcon: Icon(Icons.monitor_weight),
            ),
             SizedBox(height: 15),
            InputField(
              controller: heightController,
              obsecureText: false,
              keyboardType: TextInputType.number,
             
                validator: (value){
                   if(value==null ||value.isEmpty){
                      return "Field can't be empty";
                   }
                   return null;
              },
               labelText: "Enter your Height (cm)",
               hintText: "Height",
               prefixIcon: Icon(Icons.height),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text("Calculate BMI"),
            ),
            const SizedBox(height: 10),
            Text(
              "BMI: ${bmi.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              status,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}