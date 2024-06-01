import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

class TransformPage extends StatefulWidget {
  const TransformPage({super.key});

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> {
  Offset offset = Offset.zero;
  double rx = .0, ry = .0, rz = .0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StudyAppBar.MyAppBar("3D盒子效果", context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..rotateX(rx)
                ..rotateY(ry)
                ..rotateZ(rz),
              alignment: Alignment.center,
              child: GestureDetector(
                  onPanUpdate: (details) {
                    rx += details.delta.dx * .01;
                    ry += details.delta.dy * .01;
                    setState(() {
                      rx %= pi * 2;
                      ry %= pi * 2;
                    });
                  },
                  child: const Center(child: MyTransformWidget())),
            ),
            const SizedBox(height: 100),
            Slider(
                value: rx,
                min: pi * -2,
                max: pi * 2,
                onChanged: (v) => setState(() {
                      rx = v;
                    })),
            Slider(
                value: ry,
                min: pi * -2,
                max: pi * 2,
                onChanged: (v) => setState(() {
                      ry = v;
                    })),
            Slider(
                value: rz,
                min: pi * -2,
                max: pi * 2,
                onChanged: (v) => setState(() {
                      rz = v;
                    }))
          ],
        ));
  }
}

class MyTransformWidget extends StatefulWidget {
  const MyTransformWidget({super.key});

  @override
  State<MyTransformWidget> createState() => _MyTransformState();
}

class _MyTransformState extends State<MyTransformWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()..translate(.0, .0, -100.0),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/dao.jpg",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(100.0, .0, .0)
            ..rotateY(pi / 2),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/1.png",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(.0, 100.0, .0)
            ..rotateX(pi / 2),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/3.png",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(-100.0, .0, .0)
            ..rotateY(pi / 2),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/4.png",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          transform: Matrix4.identity()..translate(.0, .0, 100.0),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/5.png",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(.0, -100.0, .0)
            ..rotateX(pi / 2),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/4.png",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
