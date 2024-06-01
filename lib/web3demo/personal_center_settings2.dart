import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:study_demo/web3demo/personal_qr_code.dart';
import 'package:study_demo/web3demo/set_nickname.dart';

class PersonalCenterSettings2 extends StatefulWidget {
  const PersonalCenterSettings2({super.key});

  @override
  State<PersonalCenterSettings2> createState() =>
      _PersonalCenterSettings2State();
}

class _PersonalCenterSettings2State extends State<PersonalCenterSettings2> {
  //图片尺寸
  late double imageSize;
  //左右边距
  late double horizontal;
  //上下边距
  late double vertical;
  @override
  void initState() {
    super.initState();
    imageSize = 65;
    horizontal = 30;
    vertical = 10;
  }

  void copy() async {
    //复制到粘贴板
    await Clipboard.setData(const ClipboardData(
        text:
            "😘老公不在家😘\n🥵一个人寂寞🥵\n❤️想不想搞大我肚子❤️\n活力周四 激情四射\n今天是肯德基疯狂星期四\n香辣翅尖9.9十五根+鸡翅十块39.9+葡式蛋挞29.9八个\nv我80\n🔞轻松搞大我肚子🔞"));
    EasyLoading.showToast("已复制在粘贴板");
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 245),
      appBar: AppBar(
        title: const Text(
          "用户信息",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: horizontal, vertical: vertical),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/dao.jpg",
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "7_bit",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                "x001x1xxx0x0x11x" * 3,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            IconButton(
                              onPressed: () => copy(),
                              icon: Image.asset(
                                "assets/images/复制.png",
                                width: 15,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () {
                      Get.to(const PersonalQRCodePage(),
                          transition: Transition.rightToLeft);
                    },
                    icon: const Icon(Icons.qr_code))
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 30,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: horizontal - 10,
            ),
            child: Column(
              children: [
                myItem(
                  str: '设置昵称',
                  onTap: () {
                    Get.to(const SetNickname(),
                        transition: Transition.rightToLeft);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                myItem(str: "设置头像", divider: Colors.transparent)
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: horizontal - 10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                myItem(str: '社交圈'),
                const SizedBox(
                  height: 10,
                ),
                myItem(str: "添加邀请人", divider: Colors.transparent)
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget myItem({required String str, Function()? onTap, Color? divider}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  str,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Image.asset(
                  "assets/images/右箭头.png",
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
