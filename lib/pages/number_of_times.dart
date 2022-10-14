import 'package:flutter/material.dart';
import 'package:improvisation_exercise/pages/bpms.dart';
import 'package:improvisation_exercise/pages/types.dart';

class SelectChordsRepetition extends StatefulWidget {
  final List<String> setTypes;
  const SelectChordsRepetition({Key? key, required this.setTypes}) : super(key: key);
  @override
  State<SelectChordsRepetition> createState() => _SelectChordsRepetitionState();
}

class _SelectChordsRepetitionState extends State<SelectChordsRepetition> {
  // Chordタイプを選択
  final numberOftimes = [
    '1','2','3','4','5','6','7','8',
  ];
  var selectedElements = <String>[];
  late List<String> state;
  @override
  void initState(){
    super.initState();
    state = widget.setTypes;
    state.add('typeEnd');
    state.removeRange(state.indexOf('typeEnd')+1, state.length);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Please select Chord Repetition')
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            for (final type in state)
              Text(
                type,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: numberOftimes.map((times) {
                // keyが選択されているかどうかをListのcontainsメソッドを使って調べる
                final isSelected = selectedElements.contains(times);
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  onTap: selectedElements.isNotEmpty ? null : () {
                    if (isSelected) {
                      state.removeRange(state.indexOf('typeEnd')+1, state.length);
                      // すでに選択されていれば取り除く
                      selectedElements.remove(times);
                    } else {
                      state.removeRange(state.indexOf('typeEnd')+1, state.length);
                      // 選択されていなければ追加する
                      selectedElements.add(times);
                    }
                    setState(() {});
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      border: Border.all(
                        width: 2,
                        color: Colors.pink,
                      ),
                      color: isSelected ? Colors.pink : null,
                    ),
                    child: Text(
                      times,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        state.removeRange(state.indexOf('keyEnd'), state.length);
                        Navigator.of(context).pop();
                      },
                      child: const Text('戻る'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        state.removeRange(state.indexOf('typeEnd')+1, state.length);
                        selectedElements.clear();
                        //state.removeRange(state.indexOf('keyEnd')+1, state.length);
                        setState(() {});
                      },
                      child: const Text('クリア'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: selectedElements.length != 1 ? null : () {
                        state.insertAll(state.length, selectedElements);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectBpm(setNumberOftimes: List.of(state)),
                          ),
                        );
                      },
                      child: const Text("次へ"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
