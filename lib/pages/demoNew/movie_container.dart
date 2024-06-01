import 'package:flutter/material.dart';
import 'package:study_demo/pages/demoNew/movie_page.dart';

class MovieContainer extends StatefulWidget {
  const MovieContainer({super.key});

  @override
  State<MovieContainer> createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  final List<String> datas = [
    "assets/images/dao.jpg",
    "assets/images/z.jpg",
    "assets/images/dao.jpg"
  ];
  late PageController pageController;
  double pageindex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: .85);
    pageController.addListener(() {
      setState(() => pageindex = pageController.page!);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: PageView(
            controller: pageController,
            children: List.generate(
                datas.length,
                (index) =>
                    MovieCard(offset: pageindex - index, url: datas[index]))));
  }
}
