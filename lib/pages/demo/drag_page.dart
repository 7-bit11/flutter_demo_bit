import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

class DragPage extends StatefulWidget {
  const DragPage({super.key});

  @override
  State<DragPage> createState() => _DragPageState();
}

class _DragPageState extends State<DragPage> {
  double offset = 0.0;
  double myDividerWidth = 20.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("DIY左右拖拽大小组件", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final maxWidth = constraints.maxWidth * 0.5;
          const minWidth = 100.0;
          if (maxWidth + offset < minWidth) {
            offset = minWidth - maxWidth;
          } else if (maxWidth - offset < minWidth) {
            offset = maxWidth - minWidth;
          }
          return Row(
            children: [
              SizedBox(
                width: maxWidth - myDividerWidth / 2 + offset,
                child: Image.asset(
                  "assets/images/girl.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              MyDivider(
                width: myDividerWidth,
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    offset += details.delta.dx;
                  });
                },
              ),
              SizedBox(
                width: maxWidth - myDividerWidth / 2 - offset,
                child: Image.asset(
                  "assets/images/dao.jpg",
                  fit: BoxFit.cover,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class MyDivider extends StatefulWidget {
  const MyDivider(
      {super.key, required this.onHorizontalDragUpdate, required this.width});
  final Function(DragUpdateDetails details) onHorizontalDragUpdate;
  final double width;
  @override
  State<MyDivider> createState() => _MyDividerState();
}

class _MyDividerState extends State<MyDivider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          widget.onHorizontalDragUpdate(details);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: VerticalDivider(
            thickness: 4,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
