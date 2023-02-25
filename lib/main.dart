import 'package:flutter/material.dart';
import 'widgets/bot_ui.dart';

void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _changeButton(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BotChat",
      home: Scaffold(
        body: const BotUi(),
        appBar: AppBar(
          backgroundColor: Colors.purple.shade400,
          title: const Text('Nasni Bot'),
          elevation: 5,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.purple.shade400,
          selectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Ev',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Rehber',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Hesap',
            ),
          ],
          onTap: _changeButton,
        ),
      ),
    );
  }
}
