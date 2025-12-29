import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteflow/core/constants/app_colors.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = '';
  var bgColor = AppColors.babyBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your BMI Calculator'), centerTitle: true),
      //backgroundColor: AppColors.babyBlue,
      body: Container(
        color: bgColor,
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 10),

                ///Weight Controller
                TextFormField(
                  controller: wtController,
                  validator: (value) => value!.isEmpty ? 'Enter Weight' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter your Weight (in kg)'),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),

                ///Height ft Controller
                TextFormField(
                  controller: ftController,
                  validator:
                      (value) => value!.isEmpty ? 'Enter Height in Feet' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter your Height (in Feet)'),
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),

                ///Height in Controller
                TextFormField(
                  controller: inController,
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Enter Height in Inches' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter your Height (in Inches)'),
                    prefixIcon: Icon(Icons.height ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                /// Calculate BMI
                OutlinedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var inch = inController.text.toString();
                    if (wt != '' && ft != '' && inch != '') {
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iInch = int.parse(inch);

                      var tInch = (ift * 12) + iInch;
                      var tCm = tInch * 2.54;
                      var tM = tCm / 100;
                      var bmi = iwt / (tM * tM);

                      var msg = '';
                      if (bmi > 25) {
                        bgColor = Colors.orange.shade200;
                        msg = 'You are overweight';
                      } else if (bmi < 18) {
                        bgColor = Colors.red.shade200;
                        msg = 'You are underweight';
                      } else{
                        bgColor = Colors.green.shade200;
                        msg = 'You are healthy';
                      }

                      setState(
                        () => result = '$msg \n Your BMI is: ${bmi.toStringAsFixed(2)}',
                      );
                      print('Your BMI is: ${bmi.toStringAsFixed(2)}');
                    }
                  },
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  result,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
