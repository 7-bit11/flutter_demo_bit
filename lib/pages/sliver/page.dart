import 'package:flutter/material.dart';
import 'package:study_demo/pages/sliver/ex_widget.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({super.key});

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  Future _buildShareView(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: const Color.fromARGB(66, 0, 0, 0),
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(13))),
        builder: (BuildContext context) {
          return Container(
            width: 375,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 217,
                ),
                Container(
                  height: 170,
                  width: 375,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: 148,
                ),
                Container(
                  height: 297,
                  width: 375,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 244, 246, 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ],
            ),
          ).onTap(() {
            Navigator.pop(context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Scrollbar(child: buildBody1()));
  }

  buildBody2() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [
        // SliverAppBar(
        //   title: Text('导航测试'),
        // )
        SliverToBoxAdapter(
          child: Image.asset(
            "assets/images/dao.jpg",
            fit: BoxFit.cover,
            height: 200,
          ),
        )
      ];
    }, body: ListView.builder(itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 120,
        color: Colors.primaries[index % Colors.primaries.length],
        alignment: Alignment.center,
        child: Text(
          '组合ListView $index',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      );
    }));
  }

  buildBody1() {
    return CustomScrollView(slivers: [
      SliverAppBar(
        backgroundColor: Colors.green,
        //foregroundColor: Colors.red,
        stretch: true,
        expandedHeight: 300,
        floating: false,
        pinned: true,
        snap: false,
        toolbarTextStyle: TextStyle(color: Colors.white),
        flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/dao.jpg",
              fit: BoxFit.cover,
            ),
            title: const Text(
              'SliverAppBar',
              style: TextStyle(color: Colors.white),
            ),
            // collapseMode: CollapseMode.none,
            stretchModes: [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle
            ]),

        //backgroundColor: Colors.red,
      ),
      SliverToBoxAdapter(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
      SliverList.builder(
        itemBuilder: (c, i) {
          return Container(
            height: 200,
            color: Colors.blue[i * 100],
          );
        },
        itemCount: 10,
      )
    ]);
  }
}
