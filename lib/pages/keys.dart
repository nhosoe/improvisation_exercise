import 'package:flutter/material.dart';
import 'package:improvisation_exercise/pages/types.dart';

class SelectKeys extends StatefulWidget {
   const SelectKeys({Key? key}) : super(key: key);
  @override
  State<SelectKeys> createState() => _SelectKeysState();
}

class _SelectKeysState extends State<SelectKeys> {
  // 12keysを記載
  final keys = [
    'C', 'F', 'B♭', 'E♭', 'A♭', 'D♭', 'G♭', 'B', 'E', 'A', 'D', 'G',
  ];
  var selectedElements = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text('Please select keys')
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: keys.map((key) {
                // keyが選択されているかどうかをListのcontainsメソッドを使って調べる
                final isSelected = selectedElements.contains(key);
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  onTap: () {
                    if (isSelected) {
                      // すでに選択されていれば取り除く
                      selectedElements.remove(key);
                    } else {
                      // 選択されていなければ追加する
                      selectedElements.add(key);
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
                      key,
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
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // deep copy する方法
                        // selectedTags = tags だと参照を渡したことにしかならない
                        selectedElements = List.of(keys);
                        setState(() {});
                      },
                      child: const Text('全て選択'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: selectedElements.isEmpty ? null : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectTypes(setKeys: List.of(selectedElements)),
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