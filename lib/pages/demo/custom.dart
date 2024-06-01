import 'package:flutter/material.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

/* 绘制图像 */
class _CustomPageState extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("自定义画板绘制")),
      body: Center(
          //绘制区域
          child: CustomPaint(
        size: const Size(200, 200),
        painter: MyPainterBox(),
      )),
    );
  }
}

class MyPainterBox extends CustomPainter {
  final Paint _paint = Paint()..color = Colors.blueAccent.shade700;

  final Paint _paint1 = Paint()..color = Colors.yellow.shade700;

  final Paint _paint2 = Paint()..color = Colors.green.shade700;

  final Paint _paint3 = Paint()..color = Colors.red.shade700;
  // ..style = PaintingStyle.stroke
  //..invertColors = true;
  @override
  void paint(Canvas canvas, Size size) {
    print("paint===============================");
    print(size);
    //绘制矩形
    canvas.drawRect(Offset.zero & size, _paint);
    canvas.drawCircle(const Offset(100, 100), 90, _paint1);
    canvas.drawRect(
        Rect.fromCircle(center: const Offset(100, 100), radius: 50), _paint2);
    canvas.drawCircle(const Offset(100, 100), 30, _paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
