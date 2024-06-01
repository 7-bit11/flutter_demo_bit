// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';
import 'package:badges/badges.dart' as badges;

class DargTargetPage extends StatefulWidget {
  const DargTargetPage({super.key});

  @override
  State<DargTargetPage> createState() => _DargTargetPageState();
}

class _DargTargetPageState extends State<DargTargetPage>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  List<Color> currentColors = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("", context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TabBar(
            isScrollable: true,
            dividerColor: Colors.transparent,
            automaticIndicatorColorAdjustment: false,
            labelStyle: const TextStyle(fontSize: 20),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            // mouseCursor:MouseCursor.defer,
            tabs: const [
              badges.Badge(
                badgeContent: Text(''),
                child: Text("好友"),
              ),
              badges.Badge(
                badgeContent: Text('6', style: TextStyle(color: Colors.white)),
                child: Text("通讯录"),
              )
            ],
            controller: controller,
          ),
          const SizedBox(height: 20),
          Expanded(
              child: TabBarView(controller: controller, children: [
            Column(
              children: [
                DragTarget<Color>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                        width: 100,
                        height: 100,
                        color: candidateData.isNotEmpty
                            ? candidateData.first!.withOpacity(.5)
                            : getMixedColor());
                  },
                  onWillAccept: (data) => data != null,
                  onAccept: (data) {
                    currentColors.add(data);
                  },
                ),
                const SizedBox(height: 50),
                Wrap(
                  children: [
                    for (int i = 0; i < 18; i++)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Draggable(
                            data: Colors.primaries[i],
                            feedback: Container(
                              color: Colors.primaries[i],
                              width: 50,
                              height: 50,
                            ),
                            child: Container(
                              color: Colors.primaries[i],
                              width: 50,
                              height: 50,
                            )),
                      )
                  ],
                )
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      final entry = OverlayEntry(
                          builder: (c) {
                            return Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text("悬浮组件"),
                              ),
                            );
                          },
                          opaque: true);
                      Overlay.of(context).insert(entry);
                    },
                    child: const Text("悬浮按钮点击后"))
              ],
            )
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => currentColors.clear());
        },
        child: const Icon(Icons.clear),
      ),
    );
  }

  Color getMixedColor() {
    if (currentColors.isEmpty) {
      return Theme.of(context).colorScheme.inversePrimary;
    }
    int r = 0, g = 0, b = 0;
    for (var element in currentColors) {
      r += element.red;
      g += element.green;
      b += element.blue;
    }
    final count = currentColors.length;
    return Color.fromARGB(255, r ~/ count, g ~/ count, b ~/ count);
  }
}
