import 'dart:developer';

import 'package:pertemuan_6/data/db/db_helper.dart';
import 'package:pertemuan_6/data/model/transaction.dart';

class MoneyDao {
  final dbHelper = DBHelper();
  Future<int> insertTransaction(Transaction transaction) async {
    final db = await dbHelper.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<Transaction>> getAllTransactions() async {
    final db = await dbHelper.database;
    final result = await db.query('transactions');
    for (var map in result) {
      log('Transaction from DB: ${Transaction.fromMap(map).toJson()}');
    }
    return result.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<double> getIncome() async {
    final db = await dbHelper.database;
    final incomeresult = await db.rawQuery(
      'SELECT SUM(amount) as total_income FROM transactions WHERE TYPE = ?',
      ['income'],
    );
    return (incomeresult.first['total_income'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getExpense() async {
    final db = await dbHelper.database;
    final expenseresult = await db.rawQuery(
      'SELECT SUM(amount) as total_expense FROM transactions WHERE TYPE = ?',
      ['expense'],
    );
    return (expenseresult.first['total_expense'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getBalance() async {
    final income = await getIncome();
    final expense = await getExpense();
    return income - expense;
  }

  Future<int> updateTransaction(int id, Transaction transaction) async {
    final db = await dbHelper.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await dbHelper.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
