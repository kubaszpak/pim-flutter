import 'package:flutter/material.dart';
import 'package:pim/gender.dart';

class Results extends StatelessWidget {
  const Results(
      {super.key,
      required this.age,
      required this.gender,
      required this.bmi,
      required this.bodyType});

  final int age;
  final Gender gender;
  final double bmi;
  final String bodyType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text("BMI = ${bmi.toStringAsFixed(2)} - $bodyType",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(image: AssetImage('assets/equation.png'))),
              (age > 20)
                  ? const Image(image: AssetImage('assets/graph_adults.png'))
                  : (gender == Gender.male
                      ? const Image(image: AssetImage('assets/graph_boys.png'))
                      : const Image(
                          image: AssetImage('assets/graph_girls.png')))
            ],
          ),
        ),
      ),
    );
  }
}
