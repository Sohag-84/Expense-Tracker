import 'package:expense_tracker/app/models/transaction_model.dart';
import 'package:expense_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:expense_tracker/core/constant/firebase_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTransactionController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedCategoryIndex = (-1).obs;
  var selectedTypeIndex = (-1).obs;

  void selectType(int index) {
    selectedTypeIndex.value = index;
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

  // add new transaction
  Future<void> addTransaction({
    required TransactionModel transaction,
    required BuildContext context,
  }) async {
    EasyLoading.show(status: "Adding...");
    try {
      final currentUser = firebaseAuth.currentUser;

      await firestore
          .collection(userCollection)
          .doc(currentUser!.uid)
          .collection(transactionCollection)
          .add(transaction.toMap());
      Get.snackbar("Success", "Transaction added successfully");
      Get.find<HomeController>().fetchTransactions();
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "Failed to add transaction: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //update transaction
  Future<void> updateTransaction({
    required TransactionModel transaction,
    required BuildContext context,
  }) async {
    EasyLoading.show(status: "Updating...");
    try {
      final user = firebaseAuth.currentUser;
      await firestore
          .collection(userCollection)
          .doc(user!.uid)
          .collection(transactionCollection)
          .doc(transaction.id)
          .update(transaction.toMap());

      Get.snackbar("Success", "Transaction updated successfully");
      Get.find<HomeController>().fetchTransactions();
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "Failed to update transaction: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
