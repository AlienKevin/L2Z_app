import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'constants.dart';

class Example {
  List<String> conversations;
  String chinese;
  List<String> synonyms;

  Example(this.chinese, this.synonyms, this.conversations);
}

class Entry extends StatefulWidget {
  Entry(FlutterTts tts_) {
    tts = tts_;
  }

  late FlutterTts tts;
  List<Example> examples = [
    Example("表达", [
      "express",
      "utter"
    ], [
      "Hi there, I'm so glad that you could join the meeting today. Could you please be more articulate about the details of the project?",
      "Sure, the project is about creating a new advertising campaign focusing on the latest product release."
    ]),
    Example("阐述", [
      "state"
    ], [
      "What a great way to articulate the company's goals. I'm really impressed.",
      "I'm glad you think so. It can be tricky to effectively communicate the company plans to the team."
    ]),
    Example("清楚的", [
      "fluent"
    ], [
      "I really appreciate how articulate you are when explaining complex topics.",
      "Thank you! I try my best to be clear and eloquent."
    ])
  ];
  int currentExampleIndex = 0;
  int currentConversationIndex = 0;

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Words"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("articulate", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => Divider(height: 40),
            itemCount: widget.currentExampleIndex + 1,
            itemBuilder: (_, exampleIndex) => showExample(exampleIndex),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (widget.currentConversationIndex >=
                widget.examples[widget.currentExampleIndex].conversations
                        .length -
                    1) {
              widget.currentConversationIndex = 0;
              if (widget.currentExampleIndex >= widget.examples.length - 1) {
                // TODO: move to next word
              } else {
                widget.currentExampleIndex += 1;
              }
            } else {
              widget.currentConversationIndex += 1;
            }
          });
          widget.tts.speak(widget.examples[widget.currentExampleIndex]
              .conversations[widget.currentConversationIndex]);
        },
        child: Icon(Icons.chevron_right_rounded),
      ),
    );
  }

  showExample(int exampleIndex) => Column(
        children: [
          Text(
              "Conversation ${exampleIndex + 1} (${widget.examples[exampleIndex].synonyms.join(", ")} / ${widget.examples[exampleIndex].chinese})"),
          ListView.builder(
              shrinkWrap: true,
              itemCount: exampleIndex < widget.currentExampleIndex
                  ? widget.examples[exampleIndex].conversations.length
                  : widget.currentConversationIndex + 1,
              itemBuilder: (context, index) => index % 2 == 0
                  ? BubbleSpecialThree(
                      text: widget.examples[exampleIndex].conversations[index],
                      color: Theme.of(context).primaryColor,
                      tail: true,
                      isSender: true,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Theme.of(context).canvasColor),
                    )
                  : BubbleSpecialThree(
                      text: widget.examples[exampleIndex].conversations[index],
                      color: lightGray,
                      tail: true,
                      isSender: false,
                      textStyle: Theme.of(context).textTheme.bodyLarge!,
                    )),
        ],
      );
}
