import 'package:expense_tracker/app/models/transaction_model.dart';
import 'package:expense_tracker/app/modules/add_transaction/controllers/add_transaction_controller.dart';
import 'package:expense_tracker/app/modules/add_transaction/widgets/transaction_button.dart';
import 'package:expense_tracker/app/modules/auth/widgets/build_textfield.dart';
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:expense_tracker/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../widgets/transaction_category_button.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  final controller = Get.find<AddTransactionController>();

  final iconList = [
    Icons.local_restaurant_rounded,
    Icons.shopify_sharp,
    Icons.manage_search_rounded,
    Icons.car_crash_sharp,
  ];
  final titleList = ["Food", "Salary", "Utilities", "Transport"];
  final transactionList = ["Expense", "Income"];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Add Transaction'), centerTitle: true),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: customButton(
          onTap: () async {
            if (_titleController.text.trim().isEmpty) {
              Get.snackbar("Error", "Title can't be empty");
              return;
            }
            if (_amountController.text.trim().isEmpty) {
              Get.snackbar("Error", "Amount can't be empty");
              return;
            }
            if (controller.selectedTypeIndex.value == -1) {
              Get.snackbar("Error", "Please select amount type");
              return;
            }
            if (controller.selectedCategoryIndex.value == -1) {
              Get.snackbar("Error", "Please select category");
              return;
            }

            final transaction = TransactionModel(
              title: _titleController.text,
              amount: double.parse(_amountController.text),
              type: transactionList[controller.selectedTypeIndex.value],
              category: titleList[controller.selectedCategoryIndex.value],
              date: controller.selectedDate.value,
              createdAt: DateTime.now(),
            );
            await controller.addTransaction(transaction: transaction);
          },
          buttonText: "Save Transaction",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              //title text field
              buildTextField(
                controller: _titleController,
                hintText: "Title",
                icon: Icons.note_add_outlined,
              ),
              Gap(10.h),
              //amount text field
              buildTextField(
                controller: _amountController,
                hintText: "Amount",
                icon: Icons.currency_exchange_outlined,
                inputType: TextInputType.number,
              ),
              Gap(20.h),

              Obx(() {
                return Row(
                  children: List.generate(transactionList.length, (index) {
                    final isSelected =
                        controller.selectedTypeIndex.value == index;

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: transactionButton(
                          onTap: () => controller.selectType(index),
                          buttonText: transactionList[index],
                          backgroundColor: isSelected
                              ? (transactionList[index].toLowerCase() ==
                                        'income'
                                    ? Colors.green
                                    : Colors.red)
                              : whiteColor,
                          fontColor: isSelected ? Colors.white : greyColor,
                        ),
                      ),
                    );
                  }),
                );
              }),

              //expense and income button
              // Obx(() {
              //   return Row(
              //     children: List.generate(transactionList.length, (index) {
              //       final type = transactionList[index].toLowerCase();
              //       final isSelected = controller.selectedType.value == type;

              //       return Expanded(
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 5.w),
              //           child: transactionButton(
              //             onTap: () => controller.selectType(type),
              //             buttonText: transactionList[index],
              //             backgroundColor: isSelected
              //                 ? (type == 'income' ? Colors.green : Colors.red)
              //                 : whiteColor,
              //             fontColor: isSelected ? Colors.white : greyColor,
              //           ),
              //         ),
              //       );
              //     }),
              //   );
              // }),
              Gap(20.h),
              //category section
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
              Gap(5.h),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(iconList.length, (index) {
                    final isSelected =
                        controller.selectedCategoryIndex.value == index;

                    return transactionCategoryButton(
                      onTap: () {
                        controller.selectCategory(index);
                      },
                      icon: iconList[index],
                      title: titleList[index],
                      backgroundColor: isSelected ? primaryColor : whiteColor,
                    );
                  }),
                ),
              ),

              Gap(20.h),

              //date section
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
              Gap(5.h),
              Obx(
                () => Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: GestureDetector(
                    onTap: () => controller.pickDate(),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_outlined, size: 28.h),
                        Gap(20.w),
                        Text(
                          controller.formattedDate,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
