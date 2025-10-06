import 'package:expense_tracker/app/models/transaction_model.dart';
import 'package:expense_tracker/core/constant/firebase_constant.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;

  final RxDouble totalIncome = 0.0.obs;
  final RxDouble totalExpense = 0.0.obs;
  final RxDouble totalBalance = 0.0.obs;

  RxBool isTransactionLoading = false.obs;

  final RxString selectedCategory = 'All'.obs;

  List<String> categories = ['All', 'Food', 'Salary', 'Utilities', 'Transport'];

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  void calculateTotals() {
    double income = 0;
    double expense = 0;

    for (var txn in transactions) {
      if (txn.type == 'Income') {
        income += txn.amount;
      } else if (txn.type == 'Expense') {
        expense += txn.amount;
      }
    }

    totalIncome.value = income;
    totalExpense.value = expense;
    totalBalance.value = income - expense;
  }

  Future<void> fetchTransactions() async {
    transactions.clear();
    isTransactionLoading.value = true;

    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw Exception("No user logged in.");
      }

      final snapshot = await firestore
          .collection(userCollection)
          .doc(user.uid)
          .collection(transactionCollection)
          .orderBy('date', descending: true)
          .get();

      transactions.value = snapshot.docs
          .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
          .toList();

      calculateTotals();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch transactions: $e");
    } finally {
      isTransactionLoading.value = false;
    }
  }

  Future<void> deleteTransaction({required String transactionId}) async {
    try {
      await firestore
          .collection(userCollection)
          .doc(currentUser!.uid)
          .collection(transactionCollection)
          .doc(transactionId)
          .delete();

      // remove locally
      transactions.removeWhere((txn) => txn.id == transactionId);
      calculateTotals();
    } catch (e) {
      Get.snackbar("Error", "Failed to delete transaction: $e");
    }
  }

  //filter transactions by selected category
  List<TransactionModel> get filteredTransactions {
    if (selectedCategory.value == 'All') {
      return transactions;
    }
    return transactions
        .where((txn) => txn.category == selectedCategory.value)
        .toList();
  }
}
