import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../widgets/widget.dart';
import '../controller/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends GetView<HomeController> {
  static const pageId = "/HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => CommonLoader(
        isLoading: controller.isLoading.value, // Assuming you have this in your BaseController
        body: WillPopScope(
          onWillPop: () async {
            return false; // Prevents going back
          },
          child: Scaffold(
            backgroundColor: ColorsConfig.blackColor,
            key: controller.scaffoldKey,
            appBar: CommonAppBar(
              title: "Ciright Live",
              titleTextStyle: CustomTextStyle.appBarText,
              leadingIcon: "assets/images/btnMenu@2x.png",
              iconSize: 8.5,
              leadingOnTap: () {
                controller.scaffoldKey.currentState!.openDrawer();
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text("SSBI :", style: CustomTextStyle.titleTextStyle),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: Get.width * 0.4,
                          child: CommonButton(
                            name: "Take Image",
                            onPressed: () {
                              controller.pickImage();
                            },
                            color: ColorsConfig.blueButtonColor,
                            radius: 10,
                            textColor: ColorsConfig.whiteColor,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.4,
                          child: CommonButton(
                            name: "Take Video",
                            onPressed: () {
                              controller.pickVideo();
                            },
                            color: ColorsConfig.blueButtonColor,
                            radius: 10,
                            textColor: ColorsConfig.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (controller.imageList.isNotEmpty) {
                        return Column(
                          children: controller.imageList.map((file) => Image.file(file, height: 100)).toList(),
                        );
                      } else {
                        return const Center(child: Text('No images selected.'));
                      }
                    }),
                    Obx(() {
                      if (controller.videoList.isNotEmpty) {
                        return Column(
                          children: controller.videoList.map((file) => ListTile(
                            title: Text("Video: ${file.path}"),
                            // Here you can implement a video player widget if needed
                          )).toList(),
                        );
                      } else {
                        return const Center(child: Text('No videos selected.'));
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

