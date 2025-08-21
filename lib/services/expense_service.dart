import 'package:my_platform/models/database_model.dart';
import 'package:my_platform/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseService{

  Future<int> saveExpense({required ExpenseModel expenseObj}) async {
    final db = await DatabaseModel.instance.getDatabase();

    if (expenseObj.id != null){
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
    final db = await DatabaseModel.instance.getDatabase();
    var result = await db.query('expenses', orderBy: 'id ASC');
    return result.map((json) => ExpenseModel.fromJson(json)).toList();
  }

}