import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.labelLarge!),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).canvasColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))))),
      home: const MyHomePage(title: 'Home'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                  child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Business Conversation'),
                    subtitle: Row(children: [
                      Text("Finished 20%"),
                      Spacer(),
                      Text("20/100 words"),
                    ]),
                  ),
                  LinearPercentIndicator(
                    lineHeight:
                        Theme.of(context).textTheme.labelMedium!.fontSize!,
                    percent: 0.2,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                  SizedBox(
                      height:
                          Theme.of(context).textTheme.labelMedium!.fontSize!),
                  TextButton(
                    onPressed: () => {
                      // go to vocab page
                    },
                    child: Text("Continue"),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}