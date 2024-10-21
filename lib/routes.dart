import 'package:get/get.dart';

import 'binding/binding.dart';
import 'screen/screen.dart';

final List<GetPage> appPages = [
  GetPage(
      name: SplashScreen.pageId,
      page: () => SplashScreen(),
      binding: SplashBinding()),

  GetPage(
      name: HomeScreen.pageId,
      page: () => HomeScreen(),
      binding: HomeBinding()),

  GetPage(
      name: ScannedDataScreen.pageId,
      page: () => ScannedDataScreen(),
      binding: ScannedBinding()),
];