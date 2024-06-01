import 'package:flutter/material.dart';
import 'package:study_demo/frame.dart';
import 'package:study_demo/web3demo/personal_center_settings2.dart';
import 'package:study_demo/web3demo/personal_qr_code.dart';

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo")),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          getItem("个人二维码", const PersonalQRCodePage()),
          const SizedBox(height: 20),
          getItem("个人中心设置2", const PersonalCenterSettings2())
        ],
      ),
    );
  }
}
