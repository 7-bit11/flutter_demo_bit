import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelfHomePage extends StatelessWidget {
  const SelfHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
      body: Container(
        child: HomeMain(
          rpx: rpx,
        ),
      ),
    );
  }
}

class HomeMain extends StatefulWidget {
  HomeMain({Key? key, required this.rpx}) : super(key: key);
  final double rpx;
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  double extraPicHeight = 0;
  late BoxFit fitType;
  late double prev_dy;
  late double rpx;
  late AnimationController animationController;
  late Animation<double> anim;
  late TabController tabController;
  double expanedHeight = 200;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    prev_dy = 0;
    fitType = BoxFit.fitWidth;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  updatePicHeight(changed) {
    if (prev_dy == 0) {
      prev_dy = changed;
    }
    extraPicHeight += changed - prev_dy;
    if (extraPicHeight >= 200 * widget.rpx) {
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.fitWidth;
    }
    setState(() {
      prev_dy = changed;
      extraPicHeight = extraPicHeight;
      fitType = fitType;
    });
  }

  updateExpandedHeight(height) {
    setState(() {
      expanedHeight = height;
    });
  }

  runAnimate() {
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          if (extraPicHeight >= widget.rpx * 200) {
            fitType = BoxFit.fitHeight;
          } else {
            fitType = BoxFit.fitWidth;
          }
          setState(() {
            if (extraPicHeight > 0) {
              extraPicHeight = anim.value;
            }

            fitType = fitType;
          });
        });
      prev_dy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Listener(
        onPointerMove: (result) {
          updatePicHeight(result.position.dy);
        },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0);
        },
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {},
              // ),

              // expandedHeight: 510 * rpx + extraPicHeight,
              expandedHeight: expanedHeight + extraPicHeight,
              flexibleSpace: Container(
                child: TopBarWithCallback(
                  extraPicHeight: extraPicHeight,
                  fitType: fitType,
                  updateHeight: updateExpandedHeight,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  height: 100,
                  alignment: Alignment.centerLeft,
                  color: Colors.blueAccent,
                  child: Text("This is itm $index"),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20 * rpx, vertical: 10 * rpx),
                );
              }, childCount: 80),
            )
          ],
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('tabController', tabController));
  }
}

class TopBarWithCallback extends StatefulWidget {
  TopBarWithCallback(
      {Key? key,
      required this.extraPicHeight,
      required this.fitType,
      required this.updateHeight})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;
  final Function(double) updateHeight;
  _TopBarWithCallbackState createState() => _TopBarWithCallbackState();
}

class _TopBarWithCallbackState extends State<TopBarWithCallback> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverTopBar(
        extraPicHeight: widget.extraPicHeight,
        fitType: widget.fitType,
      ),
    );
  }
}

class SliverTopBar extends StatelessWidget {
  const SliverTopBar(
      {Key? key, required this.extraPicHeight, required this.fitType})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Image.asset(
      "assets/images/dao.jpg",
      width: 750 * rpx,
      height: 400 * rpx + extraPicHeight,
      fit: BoxFit.cover,
    );
  }
}

class NumWithDesc extends StatelessWidget {
  const NumWithDesc({Key? key, required this.numm, required this.desc})
      : super(key: key);
  final String numm;
  final String desc;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double textSize = 35 * rpx;
    return Padding(
        padding: EdgeInsets.only(right: 20 * rpx),
        child: Row(
          children: <Widget>[
            Text(
              numm,
              style: TextStyle(
                  fontSize: textSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10 * rpx,
            ),
            Text(desc,
                style: TextStyle(fontSize: textSize, color: Color(0xff3b3c49)))
          ],
        ));
  }
}

// import 'package:flutter/material.dart';

// class SelfHomePage extends StatelessWidget {
//   const SelfHomePage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         physics: ClampingScrollPhysics(),
//         slivers: <Widget>[
//           SliverAppBar(
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {},
//             ),
//             floating: true,
//             pinned: false,
//             snap: true,
//             expandedHeight: 250,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text("This is Sliver App Bar"),
//               background: Image.asset("lib/images/temple.jpg",height: 250,fit: BoxFit.fitWidth,),
//             ),
//           ),
//           SliverList(delegate: SliverChildBuilderDelegate((context,index){
//             return Container(child: Text("This is item $index",style: TextStyle(fontSize: 20),),color: Colors.redAccent,);
//           },))
//         ],
//       ),
//     );
//   }
// }