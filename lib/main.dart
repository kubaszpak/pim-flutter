import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pim/gender.dart';
import 'package:pim/results.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        home: const MyHomePage(title: 'BMI Calculator'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  Gender? _gender = Gender.male;
  double? _bmi;
  String? _bodyType;
  int? _age;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  String checkBodyType(int height, int weight, int age, Gender gender) {
    var bmi = weight / ((height / 100) * (height / 100));
    setState(() {
      _bmi = bmi;
    });
    if (age > 20) {
      return checkBodyTypeForAdults(bmi);
    }
    if (gender == Gender.male) {
      return checkBodyTypeForBoys(bmi, age);
    }
    // otherwise check for women
    return checkBodyTypeForGirls(bmi, age);
  }

  String checkBodyTypeBasedOnTable(
      Map<int, List<double>> bmiTable, int age, double bmi) {
    if (bmi < bmiTable[age]![0]) {
      return "Underweight";
    } else if (bmi < bmiTable[age]![1]) {
      return "Healthy weight";
    } else if (bmi < bmiTable[age]![2]) {
      return "At risk of overweight";
    } else {
      return "Overweight";
    }
  }

  String checkBodyTypeForGirls(double bmi, int age) {
    const bmiTableForGirls = {
      2: [14.15, 18.02, 19.11],
      5: [13.34, 16.80, 18.26],
      8: [13.30, 18.32, 29.70],
      11: [14.08, 20.87, 24.14],
      14: [15.44, 23.35, 27.26],
      17: [16.84, 25.20, 29.63],
      20: [17.43, 26.48, 31.76]
    };
    if (age < 2) {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 2, bmi);
    } else if (age < 5) {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 5, bmi);
    } else if (age < 8) {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 8, bmi);
    } else if (age < 11) {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 11, bmi);
    } else if (age < 14) {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 14, bmi);
    } else if (age < 17) {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 17, bmi);
    } else {
      return checkBodyTypeBasedOnTable(bmiTableForGirls, 20, bmi);
    }
  }

  String checkBodyTypeForBoys(double bmi, int age) {
    const bmiTableForBoys = {
      2: [14.74, 18.16, 19.34],
      5: [13.84, 16.84, 17.94],
      8: [13.80, 17.96, 20.07],
      11: [14.56, 20.2, 23.21],
      14: [15.99, 22.66, 26.05],
      17: [17.70, 24.94, 28.26],
      20: [19.12, 27.05, 30.59]
    };

    if (age < 2) {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 2, bmi);
    } else if (age < 5) {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 5, bmi);
    } else if (age < 8) {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 8, bmi);
    } else if (age < 11) {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 11, bmi);
    } else if (age < 14) {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 14, bmi);
    } else if (age < 17) {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 17, bmi);
    } else {
      return checkBodyTypeBasedOnTable(bmiTableForBoys, 20, bmi);
    }
  }

  String checkBodyTypeForAdults(double bmi) {
    if (bmi < 16) {
      return "Severe Thinness";
    } else if (bmi < 17) {
      return "Moderate Thinness";
    } else if (bmi < 18.5) {
      return "Mild Thinness";
    } else if (bmi < 25) {
      return "Normal";
    } else if (bmi < 30) {
      return "Overweight";
    } else if (bmi < 35) {
      return "Obese Class I";
    } else if (bmi < 40) {
      return "Obese Class II";
    } else {
      return "Obese Class III";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(60.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      _bmi = null;
                    });
                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Gender'),
                      Expanded(
                        child: ListTile(
                          title: const Text('M'),
                          leading: Radio<Gender>(
                            value: Gender.male,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _bmi = null;
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('F'),
                          leading: Radio<Gender>(
                            value: Gender.female,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _bmi = null;
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ]),
                TextFormField(
                  controller: heightController,
                  decoration: const InputDecoration(labelText: "Height"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      _bmi = null;
                    });
                  },
                ),
                TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: "Weight"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      _bmi = null;
                    });
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          setState(() {
                            _bodyType = checkBodyType(
                                int.parse(heightController.text),
                                int.parse(weightController.text),
                                int.parse(ageController.text),
                                _gender!);
                            _age = int.parse(ageController.text);
                          });
                        }
                      },
                      child: const Text('Calculate'),
                    )),
                if (_bmi != null && _bodyType != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                        "BMI = ${_bmi!.toStringAsFixed(2)} - $_bodyType",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                if (_bmi != null && _bodyType != null)
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Results(
                                bmi: _bmi!,
                                bodyType: _bodyType!,
                                age: _age!,
                                gender: _gender!),
                          ),
                        );
                      },
                      child: const Text('Inspect Results'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
