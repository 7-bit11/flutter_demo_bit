// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({super.key});

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  CounterController controller = CounterController();
  CounterController1 controller1 = CounterController1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("ChangeNotifier-Demo", context),
      body: Counter(
        controller: controller,
        controller1: controller1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.reset();
          controller1.valueNotifier.value = 0;
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final CounterController controller;
  final CounterController1 controller1;
  const Counter(
      {super.key, required this.controller, required this.controller1});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                widget.controller.count++;
              },
              child: ListenableBuilder(
                builder: (BuildContext context, Widget? child) {
                  return Text(
                    "自定义controller:${widget.controller.count}",
                    style: const TextStyle(fontSize: 40),
                  );
                },
                listenable: widget.controller,
              )),
        ),
        ElevatedButton(
            onPressed: () {
              widget.controller1.valueNotifier.value++;
            },
            child: ListenableBuilder(
              builder: (BuildContext context, Widget? child) {
                return Text(
                  "valueNotifier:${widget.controller1.valueNotifier.value}",
                  style: const TextStyle(fontSize: 40),
                );
              },
              listenable: widget.controller1.valueNotifier,
            )),
      ],
    );
  }
}

class CounterController extends ChangeNotifier {
  int _count = 0;

  int get count => _count;
  //set
  set count(value) {
    _count = value;
    //呼叫所有监听的人进行重新绘制
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class CounterController1 {
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
}
