// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

//name：zhangyu
//date：2023-7-21
//introduce：diy水印组件
class WatermarkPage extends StatefulWidget {
  const WatermarkPage({super.key});

  @override
  State<WatermarkPage> createState() => _WatermarkPageState();
}

class _WatermarkPageState extends State<WatermarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StudyAppBar.MyAppBar("水印", context),
        body:
            // Watermark1(
            //   str: '123' * 5,
            //   child: Image.asset("assets/images/2.png"),
            // )
            // MenusDemo()
            Column(
          children: [
            //   Watermark1(
            //   str: '123' * 5,
            //   child: Image.asset("assets/images/2.png"),
            // )
            Watermark(
              widget: Image.asset(
                "assets/images/dao.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              text: '11111111' * 3,
            ),
          ],
        ));
  }
}

class Watermark1 extends StatelessWidget {
  final String str;

  final Widget child;

  const Watermark1({super.key, required this.str, required this.child});

  @override
  Widget build(BuildContext context) {
    if (str == null) return child;

    return Card(
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(
                    color: Colors.white.withOpacity(0.3),
                    child: FittedBox(
                      child: Transform.rotate(
                        angle:
                            -atan(constraints.maxHeight / constraints.maxWidth),
                        child: Text(str),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Watermark extends StatefulWidget {
  const Watermark({super.key, required this.widget, required this.text});
  final Widget widget;
  final String text;
  @override
  State<Watermark> createState() => _WatermarkState();
}

class _WatermarkState extends State<Watermark> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.widget,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
            child: Container(
              transformAlignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(.3),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                          alignment: Alignment.center,
                          transformAlignment: Alignment.center,
                          transform: Matrix4.rotationZ(-0.78),
                          child: Text(widget.text)))),
            ),
          ),
        )
      ],
    );
  }
}

class MenusDemo extends StatefulWidget {
  const MenusDemo({super.key});

  @override
  _MenusDemoState createState() => _MenusDemoState();
}

class _MenusDemoState extends State<MenusDemo> {
  String _bodyStr = '显示菜单的点击';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('菜单演示'), actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  _bodyStr = value;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    const PopupMenuItem<String>(
                        value: '选项一的值', child: Text('选项一')),
                    const PopupMenuItem<String>(
                        value: '选项二的值', child: Text('选项二'))
                  ])
        ]),
        body: Center(child: Text(_bodyStr)));
  }
}
