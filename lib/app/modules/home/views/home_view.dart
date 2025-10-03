import 'package:expense_tracker/app/modules/home/widgets/balance_info_card.dart';
import 'package:expense_tracker/app/modules/home/widgets/transaction_history_container.dart';
import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.toNamed(Routes.ADD_TRANSACTION);
        },
        child: Icon(Icons.add, color: whiteColor),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final txns = controller.transactions;

          return controller.isTransactionLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // balance overview
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: balanceInfoCard(
                              title: "Total Income",
                              amount: controller.totalIncome.value
                                  .toStringAsFixed(2),
                              gradientColors: [
                                Color(0xFF8EE3A6),
                                Color(0xFF56CC9D),
                              ],
                              icon: Icons.eco,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: balanceInfoCard(
                              title: "Total Expense",
                              amount: controller.totalExpense.value
                                  .toStringAsFixed(2),
                              gradientColors: [
                                Color(0xFFFF8A8A),
                                Color(0xFFE57373),
                              ],
                              icon: Icons.arrow_downward,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: balanceInfoCard(
                              title: "Net Balance",
                              amount: controller.totalBalance.value
                                  .toStringAsFixed(2),
                              gradientColors: [
                                Color(0xFF64B6FF),
                                Color(0xFF4FC3F7),
                              ],
                              icon: Icons.account_balance_wallet,
                            ),
                          ),
                        ],
                      ),
                      Gap(10.h),
                      // Transaction List
                      Text(
                        "Transaction",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(5.h),
                      txns.isEmpty
                          ? const Center(child: Text("No transactions yet."))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: txns.length,
                              itemBuilder: (_, index) {
                                final txn = txns[index];
                                DateTime dateFromFirebase = txn.date;
                                String formattedDate = DateFormat(
                                  'd MMM y',
                                ).format(dateFromFirebase);
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: transactionHistoryContainer(
                                    title: txn.title,
                                    type: txn.type,
                                    date: formattedDate,
                                    amount: txn.amount,
                                    transactionColor: txn.type == 'Income'
                                        ? Colors.green
                                        : Colors.red,
                                    icon: txn.type == "Income"
                                        ? Icons.add
                                        : Icons.remove,
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
