import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controllerWeight = TextEditingController();
  final controllerHeight = TextEditingController();

  double indexBMI = 0;
  String indexRound = '';
  String resultBMI = '';

  void calculateBMI(String weight, String height) {
    setState(() {

      if(weight.isEmpty || height.isEmpty){
        indexRound = '-';
        resultBMI = '-';
      } else {
        indexBMI = double.parse(weight) / (double.parse(height) / 100 * double.parse(height) / 100);
        indexRound = indexBMI.toStringAsFixed(2);

        if (indexBMI < 18.5) {
          resultBMI = 'Less weight';
        } else if (indexBMI >= 18.5 && indexBMI <= 22.9) {
          resultBMI = 'Normal weight';
        } else if (indexBMI >= 23 && indexBMI <= 29.9){
          resultBMI = 'Excess weight';
        } else {
          resultBMI = 'Obesity';
        }
      }
    });
  }

  showAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Oops...'),
        content: Text('Insert your weight and height first!'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5,
            child: Text('OK', style: TextStyle(color: Colors.lightBlue),),
            onPressed: () {
              Navigator.of(context).pop();
            }
          )
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('images/bmi_image.png'),
          title: Text('BMI Calculator'),),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: controllerWeight,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: 'Weight (Kg)',
                  hintStyle: TextStyle(fontSize: 16),
                  labelText: 'Input Your Weight (Kg)',
                  labelStyle: TextStyle(fontSize: 18),
                ),
                autofocus: true,
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerHeight,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: 'Height (Cm)',
                  hintStyle: TextStyle(fontSize: 16),
                  labelText: 'Input Your Height (Cm)',
                  labelStyle: TextStyle(fontSize: 18)
                ),
                autofocus: true,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      child: Text('Calculate'),
                      onPressed: () {
                        if(controllerWeight.text.isEmpty || controllerHeight.text.isEmpty) {
                          showAlertDialog(context);
                          calculateBMI(controllerWeight.text, controllerHeight.text);
                        } else {
                          calculateBMI(controllerWeight.text, controllerHeight.text);
                        }
                      }
                    );
                  }),
                
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text('Result :'),
                        SizedBox(height: 15),
                        Text('$indexRound', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.lightBlue),),
                        SizedBox(height: 15),
                        Text('$resultBMI')
                      ],
                    ),
                  )
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}