// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  final String data;
  final Color qrColor;
  final Color backgroundColor;
  final double padding;

  const QRCode({
    super.key,
    required this.data,
    required this.qrColor,
    required this.backgroundColor,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        size: 135,
        data: data,
        version: QrVersions.auto,
        foregroundColor: qrColor,
        gapless: true,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.all(padding),
        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
        dataModuleStyle:
            const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
      ),
    );
  }
}
