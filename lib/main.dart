import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
//import 'package:color/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var colorIs = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  bool selectA = false;
  Timer? _debounce;

  void colorSwitch() {
    setState(() =>
        colorIs = Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    selectA = false;
    print('B');
  }

  void colorSpecified() {
    selectA = true;
    print('A');
  }

  void debounceColorInput(String input) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (selectA) {
        print(input);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEST',
      home: Scaffold(
          backgroundColor: colorIs,
          appBar: AppBar(
            title: const Text(
              'TEST',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                ElevatedButton(
                  onPressed: colorSpecified,
                  child: const Text('A', style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.yellow),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(40)),
                  ),
                ),
                ElevatedButton(
                  onPressed: colorSwitch,
                  child: const Text('B', style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.yellow),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(40)),
                  ),
                ),
              ]),
              TextField(
                onChanged: debounceColorInput,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  hintText: 'Enter a colour',
                ),
              )
            ],
          )),
    );
  }
}
