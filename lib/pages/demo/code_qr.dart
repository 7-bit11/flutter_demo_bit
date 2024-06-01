import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

class ScanPage extends StatelessWidget {
  final String phoneNumber;
  ScanPage({Key? key, required this.phoneNumber}) : super(key: key);

  IconData lightIcon = Icons.flash_on;
  final ScanController _controller = ScanController();

  void getResult(String result, BuildContext context) async {
    //TODO
    EasyLoading.showToast("扫描出的数据是: $result");
    await Future.delayed(Duration(seconds: 1), () {
      _controller.resume();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("扫码")),
      body: Stack(children: [
        ScanView(
          controller: _controller,
          scanLineColor: Color(0xFF4759DA),
          onCapture: (data) {
            _controller.pause();
            getResult(data, context);
          },
        ),
        Positioned(
          left: 100,
          bottom: 100,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return MaterialButton(
                  child: Icon(
                    lightIcon,
                    color: Color(0xFF4759DA),
                  ),
                  onPressed: () {
                    _controller.toggleTorchMode();
                    if (lightIcon == Icons.flash_on) {
                      lightIcon = Icons.flash_off;
                    } else {
                      lightIcon = Icons.flash_on;
                    }
                    setState(() {});
                  });
            },
          ),
        ),
        Positioned(
          right: 100,
          bottom: 100,
          child: MaterialButton(
              child: Icon(
                Icons.image,
                color: Color(0xFF4759DA),
              ),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  String? result = await Scan.parse(image.path);
                  getResult(result ?? "112321321123231", context);
                }

                // // final LostDataResponse response =
                // //     await picker.retrieveLostData();
                // if (response.isEmpty) {
                //   return;
                // }
                // final List<XFile>? files = response.files;
                // if (files != null) {
                //   _handleLostFiles(files);
                // } else {
                //   _handleError(response.exception);
                // }
                // List<Media>? res =
                //     await ImagesPicker.pick(count: 1, pickType: PickType.all);
                // if (res != null) {
                //   _controller.pause();
                //   Media image = res.first;
                //   String? result = await Scan.parse(image.path);
                //   if (result != null) {
                //     getResult(result, context);
                //   }
                // }
              }),
        ),
      ]),
    );
  }
}
