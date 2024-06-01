import 'package:flutter/material.dart';
import 'dart:math' as math;

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.offset, required this.url});
  //偏移量
  final double offset;
  final String url;

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow(offset.abs() - .5, 2) / .08));
    return Transform.translate(
      offset: Offset(-40 * gauss * offset.sign, 0),
      child: Card(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13)),
                child: Image.asset(
                  url,
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.infinity,
                  alignment: Alignment(-offset.abs() * 2 + 1, -1),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )),
    );
  }
}
