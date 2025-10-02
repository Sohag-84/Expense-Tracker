import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTransactionController extends GetxController {
  var selectedDate = DateTime.now().obs;

  var selectedCategoryIndex = (-1).obs;

  var selectedType = ''.obs;

  void selectType(String type) {
    selectedType.value = selectedType.value == type ? '' : type;
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  String get formattedDate {
    return DateFormat('d MMM y').format(selectedDate.value);
  }

  // change category index
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
