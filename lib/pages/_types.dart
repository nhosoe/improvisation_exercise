import 'package:flutter/material.dart';

class SelectTypes extends StatelessWidget {
  final List<String> setKeys;

  const SelectTypes({Key? key, required this.setKeys}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Chordタイプを選択
    final types = [
      'M7','m7','7',
    ];
    var selectedElements = <String>[];

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Please select Chord types')
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            for (final key in setKeys)
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
                      // すでに選択されていれば取り除く
                      selectedElements.remove(type);
                    } else {
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
                        selectedElements.clear();
                        setState(() {});
                      },
                      child: const Text('クリア'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // deep copy する方法
                        // selectedTags = tags だと参照を渡したことにしかならない
                        selectedElements = List.of(types);
                        setState(() {});
                      },
                      child: const Text('全て選択'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChordsRepetition(confirmedChordTypes: List.of(selectedElements)),
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
