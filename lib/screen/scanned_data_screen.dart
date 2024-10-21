import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart'; // Adjust the import based on your file structure

class ScannedDataScreen extends GetView<ScannedController> {
  static const pageId = "/ScannedDataScreen";

  const ScannedDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final String scannedData = Get.arguments ?? '';

    // Set the scanned data in the controller
    ///controller.setScannedData(controller.scannedData.value[0]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanned Data'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            // Using Obx to listen for changes in the scanned data
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.scannedData.value.isNotEmpty
                      ? controller.scannedData.value
                      : 'No data scanned.',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to HomeScreen
                  Get.back(); // This will take you back to the home screen
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
