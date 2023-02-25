import 'package:flutter/material.dart';
import 'dart:async';
import 'messages.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final List<String> _ourAnswers = [
    "How many bones are there in a human body ?",
    "What is the capital city of Turkey ?",
    "Do you use AI to answer my questions ?",
    "Hey how are you doing, are you okay ?",
  ];

  final List<String> _botQuestionAnswers = [
    "There are 206 bones in a human body.",
    "Turkey's capital city is Ankara.",
    "No I am not that smart yet.",
    "Actually, I am very good thanks for asking.",
  ];

  final _controllList = [];
  int i = 0;
  final _pairList = [];
  void _deleteQuestion(int qIndex) {
    _pairList.add({"question": _ourAnswers[qIndex], "answer": ""});
    _controllList.add(1);
    Timer(
      const Duration(seconds: 2),
      (() {
        if (_pairList.isNotEmpty) {
          _pairList[i].update("answer", (value) => _botQuestionAnswers[qIndex]);
        }
        i++;
        _controllList.remove(1);
        setState(() {
          _botQuestionAnswers.removeAt(qIndex);
        });
      }),
    );

    setState(() {
      _ourAnswers.removeAt(qIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Messages(pairList: _pairList),
        _controllList.isEmpty ? Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: _ourAnswers.map((answer) {
              return Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: ElevatedButton(
                      onPressed: () =>
                          _deleteQuestion(_ourAnswers.indexOf(answer)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.purple.shade700),
                        elevation: const MaterialStatePropertyAll(10),
                        shadowColor:
                            MaterialStateProperty.all(Colors.purple.shade800),
                      ),
                      child: Text(
                        answer,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ): const SizedBox(),
      ],
    );
  }
}
