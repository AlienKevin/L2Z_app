import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Example {
  String word;
  List<String> conversations;
  String chinese;
  List<String> synonyms;
  List<String> choices;

  Example(
      this.word, this.chinese, this.synonyms, this.conversations, this.choices);
}

class Review extends StatefulWidget {
  Review(int currentExampleIndex_) {
    currentExampleIndex = currentExampleIndex_;
    for (int i = 0; i < examples.length; i++) {
      examples[i].choices.insert(0, examples[currentExampleIndex].word);
      examples[i].choices.shuffle();
    }
  }

  late int currentExampleIndex;
  List<Example> examples = [
    Example("articulate", "表达", [
      "express",
      "utter"
    ], [
      "Hi there, I'm so glad that you could join the meeting today. Could you please be more ____ about the details of the project?",
      "Sure, the project is about creating a new advertising campaign focusing on the latest product release."
    ], [
      "feed",
      "ban",
      "create"
    ]),
    Example("industrious", "勤勉", [
      "hardworking"
    ], [
      "You've been so ____ lately. I'm really impressed with all the hard work you've been putting in.",
      "Thanks! It's really been paying off. I'm glad I've been able to stay motivated."
    ], [
      "prudent",
      "reverence",
      "infallible"
    ]),
    Example("slew", "大量", [
      "mass",
      "abundance"
    ], [
      "We have a ____ of tasks to complete today, so let's get started!",
      "Agreed, we don't want to fall behind!"
    ], [
      "tiny",
      "beautiful",
      "careful"
    ])
  ];

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  int currentAnswer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 20),
          showExample(widget.currentExampleIndex),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (widget.currentExampleIndex >= widget.examples.length - 1) {
              // TODO: stop
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Review(widget.currentExampleIndex + 1)),
              );
            }
          });
        },
        child: Icon(Icons.chevron_right_rounded),
      ),
    );
  }

  showChoices(List<String> choices) => Column(
        children: choices
            .mapIndexed(
              (index, choice) => RadioListTile(
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                title: Text(choice),
                value: index,
                groupValue: currentAnswer,
                onChanged: (int? value) {
                  setState(() {
                    if (value != null) {
                      currentAnswer = value;
                    }
                  });
                },
              ),
            )
            .toList(),
      );

  showExample(int exampleIndex) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Conversation ${exampleIndex + 1}")),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.examples[exampleIndex].conversations.length,
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
          SizedBox(height: 20.0),
          Text("Fill in the blank:"),
          showChoices(widget.examples[exampleIndex].choices),
        ],
      );
}
