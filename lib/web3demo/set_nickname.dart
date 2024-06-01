import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SetNickname extends StatefulWidget {
  const SetNickname({super.key});

  @override
  State<SetNickname> createState() => _SetNicknameState();
}

class _SetNicknameState extends State<SetNickname> {
  late TextEditingController controller = TextEditingController();

  void save() {
    if (controller.text.isNotEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
      EasyLoading.show(
          status: "保存中",
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black);
      Future.delayed(const Duration(seconds: 3), () async {
        await EasyLoading.showSuccess("保存成功",
            duration: const Duration(seconds: 1));
        Get.back();
      });
    } else {
      EasyLoading.showInfo("新昵称不能为空", duration: const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "修改昵称",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () => save(),
                style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    elevation: MaterialStatePropertyAll(0),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 108, 68, 255))),
                child: const Text(
                  "保存",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity, height: 10),
            const Text(
              "设置你的昵称",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            const Text(
              "好名字可以让你的朋友更容易记住你",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: myTextField(
                    controller: controller,
                    maxLength: 32,
                    hintText: "",
                    icon: const SizedBox(width: 30)))
          ],
        ),
      ),
    );
  }
}

Widget myTextField(
    {String hintText = "请输入",
    Widget? icon,
    bool obscurebool = false,
    int? maxLength,
    TextEditingController? controller,
    double? radius}) {
  return TextField(
    controller: controller,
    obscureText: obscurebool,
    maxLength: maxLength,
    buildCounter: (context,
        {required currentLength, required isFocused, maxLength}) {
      return Transform(
        transform: Matrix4.translationValues(0, -40, 0),
        child: Text(
          "$currentLength/$maxLength",
          style: const TextStyle(color: Colors.grey),
        ),
      );
    },
    decoration: InputDecoration(
        hintText: hintText,
        //border: const OutlineInputBorder(),
        filled: true, //设置背景色的前置条件
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        suffixIcon: icon, //remove_red_eye_outlined
        //isCollapsed: true,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(0, 135, 66, 66))), //获得焦点下划线设为蓝色
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
            borderSide:
                const BorderSide(color: Color.fromARGB(0, 159, 66, 66))),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
    // style: TextStyle(fontSize: 20),
  );
}
