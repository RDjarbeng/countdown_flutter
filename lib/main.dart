import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    formatted = DateFormat(' E -dd-LLL-yyyy').format(date);
    int difference = date.difference(DateTime(1970)).inDays;
    var timeInYears = (difference / 365).floor();
    var timeInDays = difference % 365;
    this.todayText =
        ' Today is  ${formatted} \n \n Time: ${timeInYears}years, ${timeInDays}days (${date.millisecondsSinceEpoch} seconds) \n  since 1970 epoch.\n\n  ';
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextStyle animationTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static const colorizeColors = [
    Colors.lightBlueAccent,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.orangeAccent
  ];
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
              Column(
                children: <Widget>[
                  Text(
                    'What\'s so special about ',
                    style: animationTextStyle,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'today?',
                        textStyle: animationTextStyle,
                      ),
                      TypewriterAnimatedText(
                        'Design?',
                        textStyle: animationTextStyle,
                      ),
                      ColorizeAnimatedText(
                        'your memories!',
                        textStyle: animationTextStyle,
                        colors: colorizeColors,
                      ),
                      TyperAnimatedText(
                        'this day?',
                        textStyle: animationTextStyle,
                      ),
                      ScaleAnimatedText(
                        'Anticipate',
                        textStyle: animationTextStyle,
                      ),
                      FlickerAnimatedText(
                        'the moment!',
                        textStyle: animationTextStyle,
                      ),
                    ],
                    // totalRepeatCount: 15,
                    repeatForever: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.todayText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
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
