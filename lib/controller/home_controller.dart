import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ssbi/controller/base_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:video_compress/video_compress.dart';

import '../screen/screen.dart';


// class HomeController extends BaseController {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   RxBool isBuyTkt = false.obs;
//   RxList<File> imageList = <File>[].obs;
//   RxList<File> videoList = <File>[].obs;
//   var selectedFile = Rx<File?>(null);
//
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _checkAndRequestPermissions();
//     _requestPermissions(); // Request necessary permissions on initialization
//   }
//
//   /// Request permissions for camera and storage.
//   Future<void> _requestPermissions() async {
//     if (await Permission.camera.isDenied /*|| await Permission.storage.isDenied*/) {
//       await [
//         Permission.camera,
//         //Permission.storage,
//       ].request();
//     }
//   }
//
//   Future<void> _checkAndRequestPermissions() async {
//     final cameraStatus = await Permission.camera.status;
//    // final storageStatus = await Permission.storage.status;
//
//     if (cameraStatus.isDenied /*|| storageStatus.isDenied*/) {
//       // Request permissions if they are denied
//       await [
//         Permission.camera,
//         //Permission.storage,
//       ].request();
//     } else if (cameraStatus.isPermanentlyDenied /*|| storageStatus.isPermanentlyDenied*/) {
//       // If permissions are permanently denied, open app settings
//       openAppSettings();
//     }
//   }
//
//   /// Check if permissions are granted before picking an image.
//   Future<void> pickImage() async {
//     // Check permissions before proceeding
//     if (await _checkPermissions()) {
//       try {
//         final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//         if (pickedFile != null) {
//           imageList.add(File(pickedFile.path));
//           selectedFile.value = File(pickedFile.path);
//         }
//       } catch (e) {
//         Get.snackbar("Error", "Failed to pick image: $e", backgroundColor: Colors.red);
//       }
//     } else {
//       Get.snackbar("Permission Denied", "Please grant camera and storage permissions.", backgroundColor: Colors.red);
//     }
//   }
//
//
//   /// Check if permissions are granted.
//   Future<bool> _checkPermissions() async {
//     final cameraStatus = await Permission.camera.status;
//     final storageStatus = await Permission.storage.status;
//     return cameraStatus.isGranted && storageStatus.isGranted;
//   }
//
//   /// Check if permissions are granted before picking a video.
//   Future<void> pickVideo() async {
//     // Check permissions before proceeding
//     if (await _checkPermissions()) {
//       try {
//         final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
//         if (pickedFile != null) {
//           videoList.add(File(pickedFile.path));
//           selectedFile.value = File(pickedFile.path);
//         }
//       } catch (e) {
//         Get.snackbar("Error", "Failed to pick video: $e", backgroundColor: Colors.red);
//       }
//     } else {
//       Get.snackbar("Permission Denied", "Please grant camera and storage permissions.", backgroundColor: Colors.red);
//     }
//   }
// }


///new

class HomeController extends BaseController {
  // Observable variables
  RxString email = "".obs;
  RxString name = "".obs;
  static RxString profilePic = "".obs;
  RxString pass = "".obs;
  RxString empID = ''.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  final ImagePicker _picker = ImagePicker();
  RxList<File> imageList = <File>[].obs;
  RxList<File> videoList = <File>[].obs;
  var selectedFile = Rx<File?>(null);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  RxString qrCodeDetails = ''.obs;


  @override
  void onInit() {
    super.onInit();
    _checkAndRequestPermissions(); // Request permissions on init
    print("ImageList Len: ${imageList.length}");
  }

  /// Check and request necessary permissions.
  // Future<bool> _checkAndRequestPermissions() async {
  //   final cameraStatus = await Permission.camera.request();
  //   final storageStatus = await Permission.storage.request();
  //
  //   // Debug logs
  //   print("Camera Status: ${cameraStatus}");
  //   print("Storage Status: ${storageStatus}");
  //
  //   if (cameraStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied) {
  //     openAppSettings();
  //     return false;
  //   }
  //
  //   return cameraStatus.isGranted && storageStatus.isGranted;
  // }

  Future<bool> _checkAndRequestPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;

    print("Camera Status: ${cameraStatus}");
    // Check if permissions are denied
    if (cameraStatus.isDenied /*|| storageStatus.isDenied*/) {
      print("Requesting permissions...");
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        // Permission.storage,
      ].request(); // Request all permissions

      // Update status after request
      cameraStatus = statuses[Permission.camera]!;
      //storageStatus = statuses[Permission.storage]!;
    }

    // If permissions are permanently denied, open app settings
    if (cameraStatus.isPermanentlyDenied /*|| storageStatus.isPermanentlyDenied*/) {
      print("Permissions permanently denied. Redirecting to settings.");
      Get.snackbar(
        "Permissions Required",
        "Please enable Camera and Storage permissions in App Settings.",
        backgroundColor: Colors.red,
      );
      openAppSettings(); // Redirect to app settings
      return false;
    }

    // Check if both permissions are granted
    if (cameraStatus.isGranted /*&& storageStatus.isGranted*/) {
      print("Permissions granted.");
      return true;
    } else {
      print("Permissions denied.");
      return false;
    }
  }


  /// Get  app's directory path
  Future<Directory> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final appDir = Directory("${directory.path}/MyAppFiles");

    print("App dir: ${appDir}");

    if (!(await appDir.exists())) {
      await appDir.create(recursive: true);
    }
    return appDir;
  }


  /// Pick an image from the camera and compare it with existing ones.

  ///ppppppp

  Future<void> pickImage() async {
    if (await _checkAndRequestPermissions()) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);

        if (pickedFile != null) {
          // Create a File instance from the picked file path
          File newFile = File(pickedFile.path);

          // Add the new file to the image list and update the selected file
          imageList.add(newFile);
          selectedFile.value = newFile;

          print("Image added to the list: ${newFile.path}");

          // Read the image bytes for saving to the gallery
          Uint8List imageBytes = await newFile.readAsBytes();

          // Save the image to the gallery using SaverGallery
          final result = await SaverGallery.saveImage(
            imageBytes,
            name: basename(pickedFile.path),
            fileExtension: 'jpg',
            androidExistNotSave: true,
          );

          print("Save result: ${result}");

          // Handle result for both Android and iOS
          if (result.isSuccess) {
            print("Image successfully saved to gallery at: ${newFile.path}");
            Get.snackbar(
              "Success",
              "Image saved to gallery.",
              backgroundColor: Colors.green,
            );
          } else {
            Get.snackbar(
              "Error",
              "Failed to save image to gallery.",
              backgroundColor: Colors.red,
            );
          }
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to pick image: $e",
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        "Permission Denied",
        "Please grant camera and storage permissions.",
        backgroundColor: Colors.red,
      );
    }
  }

  /*Future<void> pickImage() async {
    if (await _checkAndRequestPermissions()) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.camera);

        if (pickedFile != null) {
          // Create a File instance from the picked file path
          File newFile = File(pickedFile.path);

          // Add the new file to the image list and update the selected file
          imageList.add(newFile);
          selectedFile.value = newFile;

          print("Image added to the list: ${newFile.path}");

          // Read the image bytes for saving to the gallery
          Uint8List imageBytes = await newFile.readAsBytes();

          // Save the image to the gallery
          final result = await
          Platform.isAndroid ?
          SaverGallery.saveImage(
            imageBytes,
            name: basename(pickedFile.path),
            fileExtension: 'jpg',
            androidExistNotSave: true,
          ) :
          ImageGallerySaver.saveImage(
            imageBytes,
            quality: 100,
            name: basename(pickedFile.path),
          );

          print("Save result: ${result}");

//          Platform.isAndroid ? storeAnd(result)  : storeIos();
          if (result.isSuccess) {
            print("Image successfully saved to gallery at: ${newFile.path}");
          }
          else {
            Get.snackbar(
              "Error",
              "Failed to save image to gallery.",
              backgroundColor: Colors.red,
            );
          }
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to pick image: $e",
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        "Permission Denied",
        "Please grant camera and storage permissions.",
        backgroundColor: Colors.red,
      );
    }
  }*/

  ///ppppppp

  /// Pick a video .

  Future<void> pickVideo2() async {
    if (await _checkAndRequestPermissions()) {
      try {
        // Pick a video using the camera
        final pickedFile = await _picker.pickVideo(source: ImageSource.camera);

        if (pickedFile != null) {
          File newFile = File(pickedFile.path);

          // Save the video to the gallery
          Uint8List videoBytes = await newFile.readAsBytes();
          print("video Bytes: $videoBytes");

          final result = await SaverGallery.saveFile(
            name: basename(pickedFile.path),
            androidExistNotSave: true, file: '$videoBytes', // Prevent overwriting if already exists
          );

          print("Save result: ${result}");

          if (result.isSuccess) {
            print("Video successfully saved to the gallery.");
          } else {
            Get.snackbar(
              "Error",
              "Failed to save video to the gallery.",
              backgroundColor: Colors.red,
            );
          }

          // Save the video to the app's directory
          Directory appDir = await _getAppDirectory();
          String newPath = "${appDir.path}/${basename(pickedFile.path)}";
          File savedFile = await newFile.copy(newPath);

          print("Video copied to: ${savedFile.path}");

          // Check for duplicates in the video list
          bool isDuplicate = videoList.any((file) =>
          file.path == savedFile.path || file.lengthSync() == savedFile.lengthSync());

          if (isDuplicate) {
            Get.snackbar(
              "Duplicate Video",
              "This video has already been added.",
              backgroundColor: Colors.orange,
            );
          } else {
            // Add the video to the list and set it as the selected file
            videoList.add(savedFile);
            selectedFile.value = savedFile;
            print("Video added to the list at: ${savedFile.path}");
          }
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to pick video: $e",
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        "Permission Denied",
        "Please grant camera and storage permissions.",
        backgroundColor: Colors.red,
      );
    }
  }
  Future<void> pickVideo() async {
    if (await _checkAndRequestPermissions()) {
      try {
        // Pick a video using the camera
        final pickedFile = await _picker.pickVideo(source: ImageSource.camera);

        if (pickedFile != null) {
          File newFile = File(pickedFile.path);

          // Save the video to the gallery
          try {
            final result = await SaverGallery.saveFile(
              name: basename(pickedFile.path),
              androidExistNotSave: true,
              file: newFile.path, // Use the file path instead of bytes
            );

            print("Save result: ${result}");

            if (result.isSuccess) {
              print("Video successfully saved to the gallery.");
            } else {
              Get.snackbar(
                "Error",
                "Failed to save video to the gallery.",
                backgroundColor: Colors.red,
              );
            }
          } catch (e) {
            Get.snackbar(
              "Error",
              "Failed to save video to gallery: $e",
              backgroundColor: Colors.red,
            );
          }

          // Save the video to the app's directory
          try {
            Directory appDir = await _getAppDirectory();
            String newPath = "${appDir.path}/${basename(pickedFile.path)}";
            File savedFile = await newFile.copy(newPath);

            print("Video copied to: ${savedFile.path}");

            // Check for duplicates in the video list
            bool isDuplicate = videoList.any((file) =>
            file.path == savedFile.path ||
                file.lengthSync() == savedFile.lengthSync());

            if (isDuplicate) {
              Get.snackbar(
                "Duplicate Video",
                "This video has already been added.",
                backgroundColor: Colors.orange,
              );
            } else {
              // Add the video to the list and set it as the selected file
              videoList.add(savedFile);
              selectedFile.value = savedFile;
              print("Video added to the list at: ${savedFile.path}");
            }
          } catch (e) {
            Get.snackbar(
              "Error",
              "Failed to copy video: $e",
              backgroundColor: Colors.red,
            );
          }
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to pick video: $e",
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        "Permission Denied",
        "Please grant camera and storage permissions.",
        backgroundColor: Colors.red,
      );
    }
  }

  // Future<void> pickVideo() async {
  //   if (await _checkAndRequestPermissions()) {
  //     try {
  //       final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
  //       if (pickedFile != null) {
  //         File newFile = File(pickedFile.path);
  //
  //         // Save the file in the app's directory
  //         Directory appDir = await _getAppDirectory();
  //         String newPath = "${appDir.path}/${basename(pickedFile.path)}";
  //         File savedFile = await newFile.copy(newPath);
  //
  //         // Check if the same file exists in the list
  //         bool isDuplicate = videoList.any((file) =>
  //         file.path == savedFile.path || file.lengthSync() == savedFile.lengthSync());
  //
  //         if (isDuplicate) {
  //           Get.snackbar(
  //             "Duplicate Video",
  //             "This video has already been added.",
  //             backgroundColor: Colors.orange,
  //           );
  //         } else {
  //           videoList.add(savedFile);
  //           selectedFile.value = savedFile;
  //           print("Video saved to: ${savedFile.path}");
  //         }
  //       }
  //     } catch (e) {
  //       Get.snackbar("Error", "Failed to pick video: $e", backgroundColor: Colors.red);
  //     }
  //   } else {
  //     Get.snackbar(
  //       "Permission Denied",
  //       "Please grant camera and storage permissions.",
  //       backgroundColor: Colors.red,
  //     );
  //   }
  // }

  ///BArcode
  Future<void> scanQRCode() async {
//    Get.toNamed(ScannedDataScreen.pageId, arguments: 'scannedData');
      try {
        var scannedData = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', // Color of the cancel button
          'Cancel', // Cancel button text
          true, // Show flash icon
          ScanMode.QR, // Scan mode (QR or BARCODE)
        );
        print("Scan Data: ${scannedData}");

        if (scannedData != '-1') {
          // Navigate to ScannedDataScreen with scanned data
          //Get.to(() => ScannedDataScreen(scannedData: scannedData));
          Get.toNamed(ScannedDataScreen.pageId, arguments: [{
            'scannedData' : scannedData
          }]);
        }
      } catch (e) {
        print('Failed to scan QR code: $e');
      }
    }

  }

