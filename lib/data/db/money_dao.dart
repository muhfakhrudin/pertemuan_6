import 'package:pertemuan_6/data/db/db_helper.dart';
import 'package:pertemuan_6/data/model/transaction.dart';

class MoneyDao {
  final _dbHelper = DBHelper();

  Future<int> insertTransaction(Transaction transaction) async {
    final db = await _dbHelper.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<Transaction>> getAllTransactions() async {
    final db = await _dbHelper.database;
    final result = await db.query('transactions');

    //log get all transactions
    for (var map in result) {
      print('Transaction from DB: ${Transaction.fromMap(map).toJson()}');
    }

    return result.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<double> getIncome() async {
    final db = await _dbHelper.database;
    final incomeResult = await db.rawQuery(
      'SELECT SUM(amount) as total_income FROM transactions WHERE type = ?',
      ['income'],
    );
    return (incomeResult.first['total_income'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getExpense() async {
    final db = await _dbHelper.database;
    final expenseResult = await db.rawQuery(
      'SELECT SUM(amount) as total_expense FROM transactions WHERE type = ?',
      ['expense'],
    );
    return (expenseResult.first['total_expense'] as num?)?.toDouble() ?? 0.0;
  }

  // get balance
  Future<double> getBalance() async {
    final income = await getIncome();
    final expense = await getExpense();
    return income - expense;
  }

  Future<int> updateTransaction(int id, Transaction transaction) async {
    final db = await _dbHelper.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
