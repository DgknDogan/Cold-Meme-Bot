import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final List<dynamic> pairList;

  const Messages({required this.pairList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: pairList.map((question) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade300,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Text(
                      question["question"],
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade400,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: question["answer"].isNotEmpty
                        ? Text(
                            question["answer"],
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        : const Text(
                            "...",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
