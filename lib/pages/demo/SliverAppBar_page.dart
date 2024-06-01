// ignore_for_file: file_names

import 'package:flutter/material.dart';

//name：zhangyu
//date：2023-7-21
//introduce：SliverAppBar
class SliverAppBarPage extends StatefulWidget {
  const SliverAppBarPage({super.key});

  @override
  State<SliverAppBarPage> createState() => _SliverAppBarPageState();
}

class _SliverAppBarPageState extends State<SliverAppBarPage>
    with TickerProviderStateMixin {
  double extrapicHeight = 0;

  double dy = 0;

  late AnimationController animatedContainer;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animatedContainer = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 0.0).animate(animatedContainer);
  }

  void updateHeight(double position) {
    if (dy == 0) {
      dy = position;
    }
    extrapicHeight += position - dy;
    setState(() {
      dy = position;
      extrapicHeight = extrapicHeight;
    });
  }

  void runAnimate() {
    setState(() {
      animation =
          Tween(begin: extrapicHeight, end: .0).animate(animatedContainer)
            ..addListener(() {
              setState(() {
                if (extrapicHeight > 0) extrapicHeight = animation.value;
              });
            });
      dy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (event) {
          updateHeight(event.position.dy);
        },
        onPointerUp: (value) {
          runAnimate();
          animatedContainer.forward(from: .0);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              //floating: true,
              //snap: true,
              expandedHeight: 240 + extrapicHeight,
              stretch: true,
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: Image.asset(
                "assets/images/dao.jpg",
                fit: BoxFit.cover,
                width: 750,
                height: 300 + extrapicHeight,
              ),
            ),
            SliverToBoxAdapter(
              child: Image.asset("assets/images/4.png"),
            ),
            SliverList.builder(
              itemBuilder: (c, i) {
                return Image.asset("assets/images/${i + 1}.png");
              },
              itemCount: 13,
            )
          ],
        ),
      ),
    );
  }
}
