import 'package:flutter/material.dart';
import 'package:improvisation_exercise/pages/start.dart';

class SelectBpm extends StatefulWidget {
  final List<String> setNumberOftimes;
  const SelectBpm({Key? key, required this.setNumberOftimes}) : super(key: key);

  @override
  State<SelectBpm> createState() => _SelectBpmState();
}

class _SelectBpmState extends State<SelectBpm> {
  final bpms = [
    '60', '80', '100', '120', '140', '160'
  ];
  var selectedElements = <String>[];
  late List<String> state;
  @override
  void initState(){
    super.initState();
    state = widget.setNumberOftimes;
    state.add('numberOfTimesEnd');
    state.removeRange(state.indexOf('numberOfTimesEnd')+1, state.length);

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Please select BPM')
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
              children: bpms.map((bpm) {
                // keyが選択されているかどうかをListのcontainsメソッドを使って調べる
                final isSelected = selectedElements.contains(bpm);
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  onTap: selectedElements.isNotEmpty ? null : () {
                    if (isSelected) {
                      state.removeRange(state.indexOf('numberOfTimesEnd')+1, state.length);
                      // すでに選択されていれば取り除く
                      selectedElements.remove(bpm);
                    } else {
                      state.removeRange(state.indexOf('numberOfTimesEnd')+1, state.length);
                      // 選択されていなければ追加する
                      selectedElements.add(bpm);
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
                      bpm,
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
                        state.removeRange(state.indexOf('typeEnd'), state.length);
                        Navigator.of(context).pop();
                      },
                      child: const Text('戻る'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        state.removeRange(state.indexOf('numberOfTimesEnd')+1, state.length);
                        selectedElements.clear();
                        //state.removeRange(state.indexOf('keyEnd')+1, state.length);
                        setState(() {});
                      },
                      child: const Text('クリア'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: selectedElements .length != 1 ? null : () {
                        state.insertAll(state.length, selectedElements);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartFlashCards(setBpm: List.of(state)),
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
