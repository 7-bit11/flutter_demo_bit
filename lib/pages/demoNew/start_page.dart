import 'package:flutter/material.dart';
import 'package:study_demo/pages/demoNew/movie_container.dart';
import 'package:study_demo/pages/demoNew/sliding_container.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.grey.shade100,
          child: const Center(child: MovieContainer()
              //SlidingContainer()
              )),
    );
  }
}
