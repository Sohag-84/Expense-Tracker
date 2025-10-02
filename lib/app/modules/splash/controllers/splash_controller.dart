import 'dart:async';

import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 3), () {
      Get.offNamed(Routes.LOGIN);
    });
  }
}
