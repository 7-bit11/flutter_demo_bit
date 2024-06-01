import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';

class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("123", context),
      body: Center(
        child: GradientBound(
          width: 100,
          height: 40,
          border: 5,
          child: Container(
            width: 100,
            height: 40,
          ),
        ),
      ),
    );
  }
}

class GradientBound extends StatefulWidget {
  // 矩形 长、宽、边框宽度，其中长、宽已包含边框宽度
  final double width;
  final double height;
  final double border;
  final Widget child;
  const GradientBound({
    super.key,
    required this.width,
    required this.height,
    required this.border,
    required this.child,
  });

  @override
  State<GradientBound> createState() => _GradientBoundState();
}

class _GradientBoundState extends State<GradientBound>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ));

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            // 创建 painter
            painter: GradientBoundPainter(
              colors: [Colors.red, Colors.green],
              animation: animation.value,
              width: widget.width,
              height: widget.height,
              border: widget.border,
            ),
            // child 内容铺满容器并居中
            child: Container(
              alignment: Alignment.center,
              width: widget.width,
              height: widget.height,
              color: Colors.transparent,
              child: widget.child,
            ),
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// 渐变边框核心绘图逻辑
class GradientBoundPainter extends CustomPainter {
  final List<Color> colors;
  final double animation;
  final double width;
  final double height;
  final double border;
  const GradientBoundPainter({
    Key? key,
    required this.colors,
    required this.animation,
    required this.width,
    required this.height,
    required this.border,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        transform: GradientRotation(animation * 2 * pi),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = border;

    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBoundPainter oldDelegate) {
    return oldDelegate.colors != colors || oldDelegate.animation != animation;
  }
}
