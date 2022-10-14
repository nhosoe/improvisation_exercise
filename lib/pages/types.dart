import 'package:flutter/material.dart';
import 'package:improvisation_exercise/pages/number_of_times.dart';

class SelectTypes extends StatefulWidget {
  final List<String>  setKeys;
  const SelectTypes({Key? key, required this.setKeys}) : super(key: key);
  @override
  State<SelectTypes> createState() => _SelectTypesState();
}

class _SelectTypesState extends State<SelectTypes> {
  // Chordタイプを選択
  final types = [
    'M7','m7','7',
  ];
  var selectedElements = <String>[];
  late List<String> state;

  @override
  void initState() {
    super.initState();
    state = widget.setKeys;
    state.add('keyEnd');
    state.removeRange(state.indexOf('keyEnd')+1, state.length);
  }

  Widget build(BuildContext context) {
    //state.insertAll(state.length, selectedElements);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Please select Chord types')
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            for (final key in state)
              Text(
                key,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),

            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: types.map((type) {
                // keyが選択されているかどうかをListのcontainsメソッドを使って調べる
                final isSelected = selectedElements.contains(type);
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  onTap: () {
                    if (isSelected) {
                      state.removeRange(state.indexOf('keyEnd')+1, state.length);
                      // すでに選択されていれば取り除く
                      selectedElements.remove(type);
                    } else {
                      state.removeRange(state.indexOf('keyEnd')+1, state.length);
                      // 選択されていなければ追加する
                      selectedElements.add(type);
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
                      type,
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
                        state.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text('戻る'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        state.removeRange(state.indexOf('keyEnd')+1, state.length);
                        selectedElements.clear();
                        //state.removeRange(state.indexOf('keyEnd')+1, state.length);
                        setState(() {});
                      },
                      child: const Text('クリア'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        state.removeRange(state.indexOf('keyEnd')+1, state.length);
                        // deep copy する方法
                        // selectedTags = tags だと参照を渡したことにしかならない
                        selectedElements = List.of(types);
                        setState(() {});
                      },
                      child: const Text('全て選択'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: selectedElements.isEmpty ? null : () {
                        state.insertAll(state.length, selectedElements);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectChordsRepetition(setTypes: List.of(state)),
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
