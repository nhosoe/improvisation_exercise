import 'package:flutter/material.dart';
import 'package:improvisation_exercise/pages/keys.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SelectKeys(),
    );
  }
}

