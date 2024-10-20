import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:ssbi/constant/color_config.dart';

import 'base_controller.dart';
//
// class HomeController extends BaseController{
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   RxBool isBuyTkt = false.obs;
//
//   //RxList<String> imageList = <String>[].obs;
//
//   RxList<File> imageList = <File>[].obs;
//   RxList<File> videoList = <File>[].obs;
//
//
//   var selectedFile = Rx<File?>(null);
//   //final ImagePicker _picker = ImagePicker();
//
//
//   @override
//   void onInit() {
//
//   }
//
//   // Future<void> pickImage() async {
//   //   try {
//   //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//   //     if (pickedFile != null) {
//   //       // Add the selected image to the list
//   //       imageList.add(File(pickedFile.path));
//   //       selectedFile.value = File(pickedFile.path); // For immediate use if needed
//   //     }
//   //   } catch (e) {
//   //     print("Error : $e");
//   //     Get.snackbar("Error", "Failed to pick image: $e", backgroundColor: ColorsConfig.errorColor);
//   //   }
//   // }
//   //
//   //
//   // Future<void> pickVideo() async {
//   //   try {
//   //     final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
//   //     if (pickedFile != null) {
//   //       // Add the selected video to the list
//   //       videoList.add(File(pickedFile.path));
//   //       selectedFile.value = File(pickedFile.path); // For immediate use if needed
//   //     }
//   //   } catch (e) {
//   //     print("Error : $e");
//   //     Get.snackbar("Error", "Failed to pick video: $e",  backgroundColor: ColorsConfig.errorColor);
//   //   }
//   // }
//
//
//
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'base_controller.dart';

class HomeController extends BaseController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isBuyTkt = false.obs;
  RxList<File> imageList = <File>[].obs;
  RxList<File> videoList = <File>[].obs;
  var selectedFile = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _checkAndRequestPermissions();
    _requestPermissions(); // Request necessary permissions on initialization
  }

  /// Request permissions for camera and storage.
  Future<void> _requestPermissions() async {
    if (await Permission.camera.isDenied /*|| await Permission.storage.isDenied*/) {
      await [
        Permission.camera,
        //Permission.storage,
      ].request();
    }
  }

  Future<void> _checkAndRequestPermissions() async {
    final cameraStatus = await Permission.camera.status;
   // final storageStatus = await Permission.storage.status;

    if (cameraStatus.isDenied /*|| storageStatus.isDenied*/) {
      // Request permissions if they are denied
      await [
        Permission.camera,
        //Permission.storage,
      ].request();
    } else if (cameraStatus.isPermanentlyDenied /*|| storageStatus.isPermanentlyDenied*/) {
      // If permissions are permanently denied, open app settings
      openAppSettings();
    }
  }

  /// Check if permissions are granted before picking an image.
  Future<void> pickImage() async {
    // Check permissions before proceeding
    if (await _checkPermissions()) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          imageList.add(File(pickedFile.path));
          selectedFile.value = File(pickedFile.path);
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to pick image: $e", backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Permission Denied", "Please grant camera and storage permissions.", backgroundColor: Colors.red);
    }
  }


  /// Check if permissions are granted.
  Future<bool> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final storageStatus = await Permission.storage.status;
    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  /// Check if permissions are granted before picking a video.
  Future<void> pickVideo() async {
    // Check permissions before proceeding
    if (await _checkPermissions()) {
      try {
        final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
        if (pickedFile != null) {
          videoList.add(File(pickedFile.path));
          selectedFile.value = File(pickedFile.path);
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to pick video: $e", backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Permission Denied", "Please grant camera and storage permissions.", backgroundColor: Colors.red);
    }
  }
}



