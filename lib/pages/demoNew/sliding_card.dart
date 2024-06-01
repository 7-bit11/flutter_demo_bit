import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'movie.dart';

class SlidingCard extends StatelessWidget {
  /// 动画过程偏移量
  final double offset;

  /// 电影模型
  final Movie movie;

  const SlidingCard({
    key,
    required this.movie,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-40 * gauss * offset.sign, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
              child: Image.asset(
                movie.poster,
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                alignment: Alignment(-offset.abs() * 5, 0),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(height: 8),
                    Text('上映日期: ${movie.date}',
                        style: const TextStyle(
                          color: Colors.grey,
                        )),
                    Text(
                      movie.intro,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        Text(
                          '￥${movie.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
