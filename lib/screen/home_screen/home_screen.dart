import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/constant.dart';
import '../../../widgets/widget.dart';
import '../../controller/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends GetView<HomeController>{
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
              title: "SSBI",
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
                    Center(
                      child: Container(
                        width: Get.width * 0.5,
                        child: CommonButton(
                          name: "Scan QR",
                          onPressed: () {
                            print("pprrss");
                            controller.scanQRCode();
                          },
                          color: ColorsConfig.blueButtonColor,
                          radius: 10,
                          textColor: ColorsConfig.whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: Get.width * 0.4,
                          child: CommonButton(
                            name: "Take Image",
                            onPressed: () {
                              print("pprrss");
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
                        return GridView.builder(
                          shrinkWrap: true,  // Allows the GridView to adjust its height
                          physics: const NeverScrollableScrollPhysics(),  // Disable GridView scrolling if it's inside another scrollable widget
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,  // Number of columns
                            crossAxisSpacing: 8,  // Spacing between columns
                            mainAxisSpacing: 8,  // Spacing between rows
                          ),
                          itemCount: controller.imageList.length,
                          itemBuilder: (context, index) {
                            final file = controller.imageList[index];
                            return Image.file(file, height: 100, fit: BoxFit.cover);
                          },
                        );
                      } else {
                        return const Center(child: Text('No images selected.'));
                      }
                    }),
                    Obx(() {
                      if (controller.videoList.isNotEmpty) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,  // Adjust according to your needs
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: controller.videoList.length,
                          itemBuilder: (context, index) {
                            final file = controller.videoList[index];
                            return ListTile(
                              title: Text(
                                "Video: ${file.path}",
                                style: CustomTextStyle.fPText,
                              ),
                              // Implement a video player widget or thumbnail if needed
                            );
                          },
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

