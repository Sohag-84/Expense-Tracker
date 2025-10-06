import 'package:expense_tracker/app/modules/auth/controllers/auth_controller.dart';
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
    return DefaultTabController(
      length: controller.categories.length,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("Dashboard"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await Get.find<AuthController>().logout();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Get.toNamed(Routes.ADD_TRANSACTION);
          },
          child: Icon(Icons.add, color: whiteColor),
        ),
        body: Obx(() {
          if (controller.isTransactionLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Balance Overview
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: balanceInfoCard(
                        title: "Total Income",
                        amount: controller.totalIncome.value.toStringAsFixed(2),
                        gradientColors: [
                          const Color(0xFF8EE3A6),
                          const Color(0xFF56CC9D),
                        ],
                        icon: Icons.eco,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: balanceInfoCard(
                        title: "Total Expense",
                        amount: controller.totalExpense.value.toStringAsFixed(
                          2,
                        ),
                        gradientColors: [
                          const Color(0xFFFF8A8A),
                          const Color(0xFFE57373),
                        ],
                        icon: Icons.arrow_downward,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: balanceInfoCard(
                        title: "Net Balance",
                        amount: controller.totalBalance.value.toStringAsFixed(
                          2,
                        ),
                        gradientColors: [
                          const Color(0xFF64B6FF),
                          const Color(0xFF4FC3F7),
                        ],
                        icon: Icons.account_balance_wallet,
                      ),
                    ),
                  ],
                ),

                Gap(16.h),

                //Transactions Title
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Gap(8.h),

                //Category TabBar
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: primaryColor,
                  tabAlignment: TabAlignment.start,
                  onTap: (index) {
                    controller.selectedCategory.value =
                        controller.categories[index];
                  },
                  tabs: controller.categories
                      .map((cat) => Tab(text: cat))
                      .toList(),
                ),

                Gap(16.h),

                //Transaction List
                Obx(() {
                  final txns = controller.filteredTransactions;

                  if (txns.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: const Center(child: Text("No transactions yet.")),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: txns.length,
                    itemBuilder: (_, index) {
                      final txn = txns[index];
                      final formattedDate = DateFormat(
                        'd MMM y',
                      ).format(txn.date);

                      return Dismissible(
                        key: Key(txn.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) async {
                          await controller.deleteTransaction(
                            transactionId: txn.id,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.ADD_TRANSACTION,
                                arguments: txn,
                              );
                            },
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
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
