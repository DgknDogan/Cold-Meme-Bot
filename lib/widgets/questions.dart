import 'package:flutter/material.dart';
import 'dart:async';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'messages.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final List<String> _ourAnswers = [
    "Merhaba bir espri iyi giderdi.",
    "Bu espriyi daha önceden yapmıştın.",
    "Yeni bir tane daha alayım lütfen.",
    "Anlamadım bu bir espri mi?",
    "Bu kadar kötü espri yeter. Hoşçakal",
  ];

  final _headerList = [];
  final _coldMemesList = [];

  final _controllList = [];
  final _pairList = [];

  int i = 0;
  void _deleteQuestion(int qIndex) async {
    if (i == 0) {
      final response = await http.Client().get(Uri.parse(
          "https://www.tgrthaber.com.tr/aktuel/en-komik-soguk-espriler-en-komik-100-espri-2672820"));
      var document = parse(response.body);

      for (int a = 0;
          a < document.getElementsByClassName("header-nav__link").length;
          a++) {
        _headerList
            .add(document.getElementsByClassName("header-nav__link")[a].text);
      }
      for (int a = 0;
          a <
              document
                  .getElementsByClassName("header-nav__submenu-link")
                  .length;
          a++) {
        _headerList.add(document
            .getElementsByClassName("header-nav__submenu-link")[a]
            .text);
      }

      for (int a = 0; a < document.getElementsByTagName("li").length; a++) {
        _coldMemesList.add(document.getElementsByTagName("li")[a].text);
      }

      _coldMemesList.removeWhere((element) => _headerList.contains(element));
      _coldMemesList.removeAt(0);
    }

    int randomNum = Random().nextInt(_coldMemesList.length);

    _pairList.add({"question": _ourAnswers[qIndex], "answer": ""});
    _controllList.add(1);
    Timer(
      const Duration(seconds: 2),
      (() {
        setState(() {
          if (_pairList.isNotEmpty) {
            if (qIndex == 3) {
              _pairList[i]
                  .update("answer", (value) => "Hoşçakal, tekrar beklerim :).");
              _ourAnswers.removeAt(3);
            } else if ((qIndex == 0) & (_ourAnswers.length == 5)) {
              _ourAnswers.removeAt(0);
              _pairList[i].update(
                  "answer", (value) => _coldMemesList[randomNum] as String);
            } else if ((qIndex == 0) & (_ourAnswers.length == 4)) {
              _pairList[i]
                  .update("answer", (value) => "Üzgünüm birdaha yapmam!");
              _coldMemesList.removeAt(randomNum);
            } else if (qIndex == 2) {
              _pairList[i].update(
                  "answer", (value) => "Anlatamadım sanırım özür dilerim.");
            } else {
              _pairList[i].update(
                  "answer", (value) => _coldMemesList[randomNum] as String);
            }
          }
          i++;
          _controllList.remove(1);
        });
      }),
    );
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Messages(pairList: _pairList),
        _controllList.isEmpty & (_ourAnswers.length > 3)
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: (_ourAnswers.length == 4)
                    ? Column(
                        children: _ourAnswers.map((answer) {
                          return Column(
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 175),
                                child: ElevatedButton(
                                  onPressed: () => _deleteQuestion(
                                      _ourAnswers.indexOf(answer)),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.purple.shade700),
                                    elevation:
                                        const MaterialStatePropertyAll(10),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.purple.shade800),
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
                      )
                    : ElevatedButton(
                        onPressed: () => _deleteQuestion(0),
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
                          _ourAnswers[0],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              )
            : const SizedBox(),
      ],
    );
  }
}
