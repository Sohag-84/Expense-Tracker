import 'dart:async';

import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/constant/firebase_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Timer(Duration(seconds: 3), () {
      User? currentUser = firebaseAuth.currentUser;

      if (currentUser?.uid != null) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}
