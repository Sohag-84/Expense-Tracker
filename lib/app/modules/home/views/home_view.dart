import 'package:expense_tracker/app/modules/home/widgets/transaction_history_container.dart';
import 'package:expense_tracker/app/routes/app_pages.dart';
import 'package:expense_tracker/core/theme/colors.dart';
import 'package:flutter/material.dart';
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
              : Column(
                  children: [
                    // balance overview
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "Total Balance",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "৳ ${controller.totalBalance.value.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Income",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    "৳ ${controller.totalIncome.value.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Expense",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    "৳ ${controller.totalExpense.value.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Transaction List
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
                              return transactionHistoryContainer(
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
                              );
                            },
                          ),
                  ],
                );
        }),
      ),
    );
  }
}
