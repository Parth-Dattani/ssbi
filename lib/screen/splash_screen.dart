
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  //static const pageId = "/Splash";
  static const pageId = "/SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConfig.blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Center(
              child:Text("SSBi", style: CustomTextStyle.appBarText,),
            ),
          ],
        ),
      ),
    );
  }
}

