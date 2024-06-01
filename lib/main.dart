import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:study_demo/frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '7bit - Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.transparent))),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          toolbarHeight: 80,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
          ),
          iconTheme: IconThemeData(color: Color(0xFF212529)),
        ),
      ),
      home: const FramePage(),
      builder: EasyLoading.init(),
    );
  }
}
