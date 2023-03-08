import 'package:flutter/material.dart';

import 'questions.dart';

class BotUi extends StatelessWidget {
  const BotUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                  backgroundColor: Colors.purple.shade100,
                  child: SizedBox(
                    height: 550,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade400,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    "Hoş geldin! Bu gün senin için çok kötü esprilerim var. Sabırsızlıkla kötü espri yapmayı bekliyorum. :)",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const Question(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
        backgroundColor: Colors.purple.shade400,
        child: const Icon(Icons.textsms_rounded),
      ),
    );
  }
}
