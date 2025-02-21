// Name - Amardeep Kaur and Student number - 8917192

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 235, 176, 113)),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: "Welcome to the Application",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();
  double? output;
  String message = "";

  void _reset() {
    setState(() {
      firstNumberController.clear();
      secondNumberController.clear();
      output = null;
      message = "";
    });
  }

  void _calculateResult(String operation) {
    setState(() {
      if (firstNumberController.text.isEmpty ||
          secondNumberController.text.isEmpty) {
        message = "Please enter both the numbers.";
        output = null;
        return;
      }

      message = "";
      try {
        double num1 = double.parse(firstNumberController.text);
        double num2 = double.parse(secondNumberController.text);

        if (operation == "add") {
          output = num1 + num2;
        } else if (operation == "sub") {
          output = num1 - num2;
        } else if (operation == "mul") {
          output = num1 * num2;
        } else if (operation == "div") {
          output = num1 / num2;
        } else {
          message = "Cannot perform this operation.";
          output = null;
        }
      } catch (ex) {
        message = "Invalid input. Please enter valid input.";
        output = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("SIMPLE CALCULATOR APP",
              style: TextStyle(fontSize: 30))),
      body: Container(
        padding: const EdgeInsets.all(21),
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: firstNumberController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Enter First Number"),
            ),
            TextField(
              controller: secondNumberController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Enter Second number"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                FilledButton(
                    onPressed: () => _calculateResult("add"),
                    child: const Text("Add")),
                FilledButton(
                    onPressed: () => _calculateResult("sub"),
                    child: const Text("Sub")),
                FilledButton(
                    onPressed: () => _calculateResult("mul"),
                    child: const Text("Mul")),
                FilledButton(
                    onPressed: () => _calculateResult("div"),
                    child: const Text("Div")),
                FilledButton(
                    onPressed: () => _reset(), child: const Text("Reset")),
              ],
            ),
            Text(
              message,
              style: const TextStyle(
                  color: Color.fromARGB(255, 12, 11, 11),
                  fontSize: 20,
                  backgroundColor: Color.fromARGB(255, 235, 176, 113)),
            ),
            if (output != null)
              Text(
                "Output - $output",
                style: const TextStyle(
                    color: Color.fromARGB(255, 12, 11, 11),
                    fontSize: 20,
                    backgroundColor: Color.fromARGB(255, 235, 176, 113)),
              ),
            Container(
                padding: const EdgeInsets.all(20),
                child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const StudentLoanApp();
                        }),
                      );
                    },
                    child: const Text("Student Loan App")))
          ],
        ),
      ),
    );
  }
}

class StudentLoanApp extends StatefulWidget {
  const StudentLoanApp({super.key});

  @override
  State<StudentLoanApp> createState() => StudentLoanAppState();
}

class StudentLoanAppState extends State<StudentLoanApp> {
  final nameController = TextEditingController();
  final loanAmountController = TextEditingController();
  final rateOfInterestController = TextEditingController();
  final loanDurationController = TextEditingController();
  String errorMessage = "";
  double calculatedInterest = 0;
  double monthlyInstallment = 0;

  void _reset() {
    setState(() {
      nameController.clear();
      loanAmountController.clear();
      rateOfInterestController.clear();
      loanDurationController.clear();
      calculatedInterest = 0;
      monthlyInstallment = 0;
      errorMessage = "";
    });
  }

  void _calculateInterest() {
    setState(() {
      try {
        String name = nameController.text;
        double? loanAmount = double.parse(loanAmountController.text);
        double? rateOfInterest = double.parse(rateOfInterestController.text);
        double? loanDuration = double.parse(loanDurationController.text);

        calculatedInterest = (loanAmount * rateOfInterest * loanDuration) / 100;
        monthlyInstallment =
            (loanAmount + calculatedInterest) / (loanDuration * 12);

        errorMessage = "";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MonthlyInstallmentApp(
                      name: name,
                      loanAmount: loanAmount,
                      rateOfInterest: rateOfInterest,
                      loanDuration: loanDuration,
                      calculatedInterest: calculatedInterest,
                      monthlyInstallment: monthlyInstallment,
                    )));
      } catch (ex) {
        errorMessage = "Invalid input. Please enter valid input.";
        calculatedInterest = 0;
        monthlyInstallment = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("STUDENT LOAN CALCULATOR APP",
              style: TextStyle(fontSize: 30))),
      body: Container(
        padding: const EdgeInsets.all(21),
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: "Input Name"),
            ),
            TextField(
              controller: loanAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Input Loan Amount"),
            ),
            TextField(
              controller: rateOfInterestController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Input Rate of Interest"),
            ),
            TextField(
              controller: loanDurationController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Loan Duration in years"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                FilledButton(
                    onPressed: () => _calculateInterest(),
                    child: const Text("Calculate")),
                FilledButton(
                    onPressed: () => _reset(), child: const Text("Reset")),
              ],
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                  color: Color.fromARGB(255, 12, 11, 11),
                  fontSize: 20,
                  backgroundColor: Color.fromARGB(255, 235, 176, 113)),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyInstallmentApp extends StatelessWidget {
  final String name;
  final double loanAmount;
  final double rateOfInterest;
  final double loanDuration;
  final double calculatedInterest;
  final double monthlyInstallment;

  const MonthlyInstallmentApp({
    super.key,
    required this.name,
    required this.loanAmount,
    required this.rateOfInterest,
    required this.loanDuration,
    required this.calculatedInterest,
    required this.monthlyInstallment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("MONTHLY INSTALLMENT FOR LOAN AMOUNT",
              style: TextStyle(fontSize: 30))),
      body: Container(
        padding: const EdgeInsets.all(21),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        alignment: const Alignment(0, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Name : $name',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 12, 11, 11),
                    fontSize: 20,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Loan Amount: $loanAmount',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 12, 11, 11),
                    fontSize: 20,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Interest: $calculatedInterest',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 12, 11, 11),
                    fontSize: 20,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Monthly Payment: \$$monthlyInstallment',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 12, 11, 11),
                    fontSize: 20,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(18),
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 240, 133, 3),
                  ),
                  child: const Text('BACK'),
                )),
          ],
        ),
      ),
    );
  }
}
