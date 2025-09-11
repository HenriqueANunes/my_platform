import 'package:my_platform/models/database_model.dart';
import 'package:my_platform/models/finance/expense_model.dart';
import 'package:my_platform/models/finance/history_model.dart';
import 'package:sqflite/sqflite.dart';

class FinanceService {

  Future<Database> getDb() async {
    return await DatabaseModel.instance.getDatabase();
  }

  Future<int> saveExpense({required ExpenseModel expenseObj}) async {
    final db = await getDb();

    if (expenseObj.id != null) {
      return await db.update(
        'expenses',
        expenseObj.toMap(),
        where: 'id = ?',
        whereArgs: [expenseObj.id]
      );
    } else {
      return await db.insert(
        'expenses',
        expenseObj.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace
      );
    }
  }

  Future<List<ExpenseModel?>> getAllExpenses() async {
    final db = await getDb();
    final dateNow = DateTime.now().millisecondsSinceEpoch;
    var result = await db.query(
      'expenses',
      orderBy: 'id ASC',
      where: '((date_start <= ? and date_end >= ?) or date_start is null or date_end is null)',
      whereArgs: [dateNow, dateNow],
    );
    return result.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<double> getTotal({isCredit = true}) async {
    final db = await getDb();
    final dateNow = DateTime.now().millisecondsSinceEpoch;

    String filter = '';
    if (!isCredit){
      filter = ' and not is_credit';
    }

    var result = await db.query(
      'expenses',
      columns: ['sum(value) as total'],
      orderBy: 'id ASC',
      where: '((date_start <= ? and date_end >= ?) or date_start is null or date_end is null) $filter',
      whereArgs: [dateNow, dateNow],
    );
    return result[0]['total'] == null ? 0.0 : double.parse(result[0]['total'].toString());
  }

  Future<bool> deleteExpense(int id) async {
    final db = await getDb();
    var result = await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result != 0){
      return true;
    } else {
      return false;
    }
  }

  Future<int> saveHistory({required HistoryModel historyObj}) async {
    final db = await getDb();

    if (historyObj.yearmonth != null) {
      return await db.update(
          'history_revenue',
          historyObj.toMap(),
          where: 'yearmonth = ?',
          whereArgs: [historyObj.yearmonth]
      );
    } else {
      return await db.insert(
        'history_revenue',
        historyObj.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace
      );
    }
  }
}
