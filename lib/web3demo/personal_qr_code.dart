// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

/*个人二维码页*/
class PersonalQRCodePage extends StatefulWidget {
  const PersonalQRCodePage({super.key});

  @override
  State<PersonalQRCodePage> createState() => _PersonalQRCodePageState();
}

class _PersonalQRCodePageState extends State<PersonalQRCodePage> {
  //图片大小，整个页面需要用来设置各种边距条件
  late double height;
  //边框圆角值
  late double circular;

  late var qrwidget = GlobalKey();
  @override
  void initState() {
    super.initState();
    height = 70.0;
    circular = 13.0;
  }

  // 根据GlobalKey来获取组件的截图 转换为uint数据
  static Future<Uint8List?> makeImageUInt8List(GlobalKey globalKey) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0); // 调整分辨率以适应高像素密度设备
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }

  Future<bool> ImageSave() async {
    bool isSuccess = false;
    Uint8List? uint8list = await makeImageUInt8List(qrwidget);
    //保存到相册
    if (uint8list != null) {
      final result = await ImageGallerySaver.saveImage(
        uint8list,
        quality: 100,
      );
      Map map = result;
      if (map.containsKey("isSuccess")) {
        isSuccess = map['isSuccess'];
      }
    }
    return isSuccess;
  }

  //分享
  void shareMethod() async {
    EasyLoading.show(status: "加载中");
    Uint8List? uint8list = await makeImageUInt8List(qrwidget);
    EasyLoading.show(status: "加载完成");
    if (uint8list != null) {
      final result = await Share.shareXFiles(
        [XFile.fromData(uint8list, mimeType: "分享.png")],
      );
      if (result.status == ShareResultStatus.dismissed) {
        EasyLoading.showInfo("取消分享", duration: Duration(seconds: 1));
      }
      if (result.status == ShareResultStatus.success) {
        EasyLoading.showSuccess("完成", duration: Duration(seconds: 1));
      }
    }
  }

  //保存
  void save() async {
    EasyLoading.show(status: "下载中");
    bool data = await ImageSave();
    EasyLoading.showSuccess(data ? "下载成功" : "下载失败",
        duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "二维码",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.transparent)),
            icon: Image.asset("assets/images/返回.png", width: 26)),
        actions: [
          IconButton(
              style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () => shareMethod(),
              icon: Image.asset("assets/images/编组 8.png", width: 18))
        ],
      ),
      body: RepaintBoundary(
        key: qrwidget,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              "assets/images/查看图片.png",
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(circular)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -(height / 2)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "assets/images/dao.jpg",
                                width: height,
                                height: height,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "7-bit",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "扫描下方二维码加我为好友",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    QrImageView(
                      data: '疯狂星期四vivo50',
                      version: QrVersions.auto,
                      dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.circle,
                          color: Colors.black),
                      eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.circle, color: Colors.black),
                      size: 220.0,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: thisWidgetButton(
                              text: '保存图片',
                              onPressed: () => save(),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(circular))),
                        ),
                        Container(
                          width: 1,
                          height: height - 30,
                          color: Colors.grey.shade200,
                        ),
                        Expanded(
                            child: thisWidgetButton(
                                text: '分享',
                                onPressed: () => shareMethod(),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(circular)))),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/海外.png",
                      width: 22,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Block Chat",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //在这个页面中可以复用的按钮组件
  Widget thisWidgetButton(
      {required String text,
      TextStyle? style,
      MaterialStatePropertyAll<Color?>? buttonColor,
      BorderRadiusGeometry? borderRadius,
      Function()? onPressed}) {
    return SizedBox(
      height: height - 10,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: borderRadius ??
                    BorderRadius.only(bottomRight: Radius.circular(circular)),
              ),
            ),
            elevation: const MaterialStatePropertyAll(0),
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            backgroundColor: buttonColor ??
                MaterialStatePropertyAll(Color.fromARGB(255, 250, 250, 250))),
        child: Text(
          text,
          style: style ??
              const TextStyle(
                  color: Color.fromARGB(255, 124, 181, 159), fontSize: 18),
        ),
      ),
    );
  }
}
