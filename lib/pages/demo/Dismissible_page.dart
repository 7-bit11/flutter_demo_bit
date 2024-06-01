// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_demo/pages/QQ/user_option_page.dart';
import 'package:study_demo/widget/appbar.dart';

//name：zhangyu
//date：2023-7-21
//introduce：Dismissible-左右滑动删除
class DismissiblePage extends StatefulWidget {
  const DismissiblePage({super.key});

  @override
  State<DismissiblePage> createState() => _DismissiblePageState();
}

class _DismissiblePageState extends State<DismissiblePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("左右滑动删除", context),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 3));
          setState(() {});
        },
        child: ListView.builder(
            itemCount: 13,
            itemBuilder: (c, i) {
              return Dismissible(
                key: UniqueKey(),
                background: const UserOptionPage(),
                //  Container(
                //   alignment: Alignment.centerLeft,
                //   padding: const EdgeInsets.all(20),
                //   child: const Text("删除", style: TextStyle(fontSize: 20)),
                // ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(20),
                  child: const Text("取消", style: TextStyle(fontSize: 20)),
                ),
                movementDuration: const Duration(seconds: 1), //滑动动画时间
                resizeDuration: const Duration(seconds: 1), //滑动操作完成后删除或回弹动画时长
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Get.to(UserOptionPage(),
                    //     transition: Transition.rightToLeft);
                    return false;
                  } else {
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("提示"),
                            content: const Text("是否确认删除"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("删除"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("取消"),
                              )
                            ],
                          );
                        });
                  }
                  return null;
                },
                child: Image.asset(
                  "assets/images/${i + 1}.png",
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              );
            }),
      ),
    );
  }
}
