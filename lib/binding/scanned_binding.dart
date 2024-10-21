import 'package:ssbi/controller/controller.dart';
import 'package:get/get.dart';



class ScannedBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ScannedController>(ScannedController(), permanent: false);
  }

}
