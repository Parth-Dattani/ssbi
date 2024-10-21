import 'package:get/get.dart';
import 'package:ssbi/controller/base_controller.dart';

class ScannedController extends BaseController{

  var scannedData = ''.obs;
  dynamic argumentData;
  RxList<dynamic> scanList = <dynamic>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    argumentData = Get.arguments;
    print("Argument: ${argumentData}");
    scannedData.value = argumentData[0]['scannedData'];
    //scanList.value.  = argumentData[0]['scannedData'];
    print("Scan List: ${scanList.value}");
    //final String scannedDatas = Get.arguments ?? '';

    super.onInit();
  }

  void setScannedData(List<dynamic> data) {
    scanList.value = data;
  }
}