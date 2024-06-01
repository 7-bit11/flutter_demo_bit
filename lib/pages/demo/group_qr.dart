import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:study_demo/pages/widget/qr_code.dart';

//name：liuhao
//date：2023年7月21日
//introduce：组件截图，用于个人或群组二维码保存
// ignore: must_be_immutable
class GroupQr extends StatelessWidget {
  GroupQr({Key? key}) : super(key: key);

  GlobalKey comGlobalKey = GlobalKey();

  Future<Uint8List?> takeScreenshot() async {
    try {
      RenderRepaintBoundary boundary = comGlobalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image =
          await boundary.toImage(pixelRatio: 3.0); // 调整分辨率以适应高像素密度设备
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        return pngBytes;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _requestPermission() async {
    await Permission.photos.request();
  }

  Future<void> _downloadAndSaveImage() async {
    final bytes = await takeScreenshot();
    final result = await ImageGallerySaver.saveImage(
      bytes!,
      quality: 100,
    );

    if (result['isSuccess'] == true) {
      EasyLoading.showToast("已保存到相册",
          duration: const Duration(milliseconds: 1500));
    } else {
      EasyLoading.showToast("异常", duration: const Duration(milliseconds: 1500));
    }
  }

  Future<void> saveImageToTodayAlbum() async {
    await _requestPermission();
    await _downloadAndSaveImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Custom QR Code'),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://img0.baidu.com/it/u=2157226751,1711025478&fm=253&fmt=auto&app=138&f=JPEG?w=281&h=500"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            RepaintBoundary(
              key: comGlobalKey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 140, 30, 30),
                    child: PhysicalModel(
                      elevation: 10,
                      clipBehavior: Clip.hardEdge,
                      color: Colors.black12,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://img0.baidu.com/it/u=3381827543,2348597132&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500"),
                                        fit: BoxFit.fitWidth)),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "未命名群组",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: const QRCode(
                                        data: 'https://www.example.com',
                                        qrColor: Colors.black, // 自定义前景色为蓝色
                                        backgroundColor:
                                            Colors.transparent, // 自定义背景色为白色
                                        padding: 0, // 设置二维码的边距为0
                                      ),

                                      // color: Colors.blue,
                                    ),
                                    const Text(
                                      "137用户在这里",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black26),
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.grey[100],
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Block Chat",
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "在区块的世界不期而遇",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black38),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: MediaQuery.of(context).size.width / 2 -
                          MediaQuery.of(context).size.width / 5 / 2,
                      top: 200,
                      child: PhysicalModel(
                        color: Colors.black12,
                        clipBehavior: Clip.hardEdge,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9)),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          color: Colors.orange,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 120,
                  height: 50,
                  onPressed: () async {
                    await Clipboard.setData(const ClipboardData(
                        text:
                            "😘老公不在家😘\n🥵一个人寂寞🥵\n❤️想不想搞大我肚子❤️\n活力周四 激情四射\n今天是肯德基疯狂星期四\n香辣翅尖9.9十五根+鸡翅十块39.9+葡式蛋挞29.9八个\nv我80\n🔞轻松搞大我肚子🔞"));
                    EasyLoading.showToast("已复制在粘贴板");
                  },
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "复制链接",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color.fromARGB(255, 106, 82, 214)),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  minWidth: 120,
                  height: 50,
                  onPressed: () {
                    saveImageToTodayAlbum();
                  },
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "保存到手机",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color.fromARGB(255, 106, 82, 214)),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
