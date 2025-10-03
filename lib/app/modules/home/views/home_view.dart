import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.toNamed(Routes.ADD_TRANSACTION);
        },
        child: Icon(Icons.add, color: whiteColor),
      ),
      body: const Center(child: Text('Home', style: TextStyle(fontSize: 20))),
    );
  }
}
