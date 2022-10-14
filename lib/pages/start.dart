import 'package:flutter/material.dart';

class StartFlashCards extends StatefulWidget {
  final List<String> setBpm;
  const StartFlashCards({Key? key, required this.setBpm}) : super(key: key);

  @override
  State<StartFlashCards> createState() => _StartFlashCardsState();
}

class _StartFlashCardsState extends State<StartFlashCards> {
  late List<String> state;
  @override
  void initState(){
    super.initState();
    state = widget.setBpm;
    state.add('bpmEnd');
  a
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Start!')
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [

            // for (final type in state)
            //   Text(
            //     type,
            //     style: const TextStyle(
            //       fontSize: 30,
            //     ),
            //   ),
            const Divider(color: Colors.black,),
            const Divider(color: Colors.black,),
            const Divider(color: Colors.black,),
            const Divider(color: Colors.black,),
            const Divider(color: Colors.black,),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        state.removeRange(state.indexOf('numberOfTimesEnd'), state.length);
                        Navigator.of(context).pop();
                      },
                      child: const Text('戻る'),
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
