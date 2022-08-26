import 'package:flutter/material.dart';
import 'package:dots_picker/dots_picker.dart';
import 'package:dots_picker/dot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dots Picker',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Dot chosenDot = dotsList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dots Picker'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chosenDot.name,
            style: TextStyle(fontSize: 24, color: chosenDot.color),
          ),
          const SizedBox(height: 40),
          DotsPicker(
            dots: dotsList,
            onSelected: (id) => setState(() => chosenDot = dotsList[id]),
          )
        ],
      ),
    );
  }

  List<Dot> get dotsList {
    return [
      Dot('Option 1', Colors.blue),
      Dot('Option 2', Colors.red),
      Dot('Option 3', Colors.green),
      Dot('Option 4', Colors.purple),
    ];
  }
}
