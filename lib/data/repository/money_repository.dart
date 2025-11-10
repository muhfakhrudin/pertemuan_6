import 'package:pertemuan_6/data/db/money_dao.dart';
import 'package:pertemuan_6/data/model/transaction.dart';

class MoneyRepository {
  final _moneyDao = MoneyDao();

  Future<int> insertTransaction(Transaction transaction) async {
    return await _moneyDao.insertTransaction(transaction);
  }

  Future<List<Transaction>> getAllTransactions() async {
    return await _moneyDao.getAllTransactions();
  }

  Future<double> getIncome() async {
    return await _moneyDao.getIncome();
  }

  Future<double> getExpense() async {
    return await _moneyDao.getExpense();
  }

  Future<double> getBalance() async {
    return await _moneyDao.getBalance();
  }

  Future<int> updateTransaction(int id, Transaction transaction) async {
    return await _moneyDao.updateTransaction(id, transaction);
  }

  Future<int> deleteTransaction(int id) async {
    return await _moneyDao.deleteTransaction(id);
  }
}
