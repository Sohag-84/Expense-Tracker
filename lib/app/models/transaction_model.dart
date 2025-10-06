import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final String type;
  final String category;
  final DateTime date;
  final DateTime createdAt;

  TransactionModel({
    this.id = '',
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'date': Timestamp.fromDate(date),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map, String docId) {
    return TransactionModel(
      id: docId,
      title: map['title'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      type: map['type'] ?? '',
      category: map['category'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // factory TransactionModel.fromMap(Map<String, dynamic> map, String docId) {
  //   return TransactionModel(
  //     id: docId,
  //     title: map['title'] ?? '',
  //     amount: (map['amount'] as num).toDouble(),
  //     type: map['type'] ?? '',
  //     category: map['category'] ?? '',
  //     date: (map['date'] as Timestamp).toDate(),
  //     createdAt: (map['createdAt'] as Timestamp).toDate(),
  //   );
  // }
}
