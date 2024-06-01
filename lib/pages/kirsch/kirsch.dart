import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_demo/pages/kirsch/raw_picture.dart';
import 'package:study_demo/widget/appbar.dart';
import 'dart:ui' as ui;

class Kirsch extends StatefulWidget {
  const Kirsch({super.key});

  @override
  State<Kirsch> createState() => _KirschState();
}

class _KirschState extends State<Kirsch> {
  Uint8List? _uint8list;
  ui.Image? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("转换图片颜色值生成新图片", context),
      body: Column(
        children: [
          Image.asset("assets/images/dao.jpg"),
          if (_uint8list != null)
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: Image.memory(
                _uint8list!,
                fit: BoxFit.cover,
              ),
            )),
          if (_image != null)
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: RawImage(
                image: _image,
                fit: BoxFit.cover,
              ),
            ))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: process),
    );
  }

  void process() async {
    RawPicture rawPicture = RawPicture();
    await rawPicture.initAssets("assets/images/dao.jpg");

    for (var i = 0; i < rawPicture.bytes.length; i += 4) {
      final r = rawPicture.bytes[i];
      final g = rawPicture.bytes[i + 1];
      final b = rawPicture.bytes[i + 2];
      final double brightness = r * .3 + g * .6 + b * .1;
      rawPicture.bytes[i] = brightness.toInt();
      rawPicture.bytes[i + 1] = brightness.toInt();
      rawPicture.bytes[i + 2] = brightness.toInt();
    }
    ui.Image image = await rawPicture.toRawImage();
    setState(() => _image = image);
    // Uint8List uint8list = await rawPicture.toPngBytes();
    // setState(() => _uint8list = uint8list);
  }
}
