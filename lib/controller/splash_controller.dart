
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssbi/screen/home_screen.dart';

import 'base_controller.dart';


class SplashController extends BaseController{

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3),
          ()=> checkLogin2(),);
    super.onInit();
  }

  
  void checkLogin2(){
    Get.toNamed(HomeScreen.pageId);
  }



}