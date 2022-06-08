import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Memory app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'How long since'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) {
    updateDateString();
  }
  DateTime date = DateTime.now();
  String formatted = '';
  String todayText = '';
  final String title;
  void updateDateString() {
    formatted = DateFormat(' E -dd-LLL-yyyy – kk:mm').format(date);
    var timeInDays = date.difference(DateTime(1970)).inDays;
    var timeInYears = (timeInDays / 365).floor();
    this.todayText =
        ' Today is  ${formatted} \n Which is ${date.millisecondsSinceEpoch}s \n  since 1970 epoch.\n\n Time: ${timeInDays}days or ${timeInYears}years';
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'What\'s so special about today?',
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.todayText),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1800),
              lastDate: DateTime(2100),
            );

            if (newDate == null)
              return;
            else
              setState(() {
                widget.date = newDate;
                widget.updateDateString();
              });
          },
          tooltip: 'Increment',
          child: Text('Select Date')),
    );
  }
}
