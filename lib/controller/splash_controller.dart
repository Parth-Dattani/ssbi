
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssbi/screen/home_screen/home_screen.dart';

import 'base_controller.dart';


class SplashController extends BaseController{

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3),
          ()=> goToHome(),);
    super.onInit();
  }


  void goToHome(){
    Get.toNamed(HomeScreen.pageId);
  }

}