import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class RawPicture {
  late Uint8List bytes;
  late int width;
  late int height;

  Future<void> initAssets(String loadPath) async {
    final data = await rootBundle.load(loadPath);
    final imgae = await decodeImageFromList(data.buffer.asUint8List());
    final bytedata = (await imgae.toByteData())!.buffer.asUint8List();
    width = imgae.width;
    height = imgae.height;
    bytes = bytedata;
  }

  Future<ui.Image> toRawImage() async {
    final immutableBuffer = await ImmutableBuffer.fromUint8List(bytes);
    final raw = ui.ImageDescriptor.raw(immutableBuffer,
        width: width, height: height, pixelFormat: ui.PixelFormat.rgba8888);
    final codec = await raw.instantiateCodec();
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<Uint8List> toPngBytes() async {
    final ui.Image image = await toRawImage();
    final toByteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return toByteData!.buffer.asUint8List();
  }
}
