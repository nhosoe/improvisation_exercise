import 'package:flutter/material.dart';
import 'package:improvisation_exercise/pages/types.dart';

class ChordsRepetition extends StatefulWidget {
  final List<String> confirmedChordTypes;
  const ChordsRepetition({Key? key, required this.confirmedChordTypes}) : super(key: key);
  @override
  State<ChordsRepetition> createState() => _ChordsRepetitionState();
}

class _ChordsRepetitionState extends State<ChordsRepetition> {
  late List<String> state;
  @override
  void initState(){
    super.initState();
    state = widget.confirmedChordTypes;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Number of times per chord"),
      ),
      body: Center(
        child: Column(
          children: [
            for (final chords in state)
              Text(
                chords,
                style: const TextStyle(
                  fontSize: 30,
                ),
              )
          ],
        ),
      ),
    );
  }
}
