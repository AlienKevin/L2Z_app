import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spartahack8/constants.dart';

import 'entry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
                      Theme.of(context).textTheme.bodyLarge!),
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
  late FlutterTts tts;

  @override
  void initState() {
    initTts();
  }

  void initTts() async {
    tts = FlutterTts();
    // await tts.setSharedInstance(true);
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(1.0);
    await tts.setVolume(1.0);
    await tts.setPitch(1.0);
    await tts.isLanguageAvailable("en-US");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
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
                          Theme.of(context).textTheme.bodyLarge!.fontSize!,
                      percent: 0.2,
                      backgroundColor: lightGray,
                      progressColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                        height:
                            Theme.of(context).textTheme.bodyLarge!.fontSize!),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Entry(tts)),
                        )
                      },
                      child: Text("5 words left for today"),
                    ),
                    SizedBox(height: 10)
                  ],
                )),
                SizedBox(height: 40),
                Text("Daily Vocab Goals"),
                LineGraph(
                  features: [
                    Feature(
                      title: "Words",
                      color: Colors.blue,
                      data: [0.2, 0.8, 1, 0.7, 0.6],
                    ),
                  ],
                  size: Size(500, 200),
                  labelX: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
                  labelY: ['2', '4', '6', '8', '10'],
                  graphOpacity: 0.2,
                  verticalFeatureDirection: true,
                )
              ]),
        ),
      ),
    );
  }
}
