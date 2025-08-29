import 'package:my_platform/models/database_model.dart';
import 'package:my_platform/models/expense_model.dart';

class ExpenseService {

  Future<int> saveExpense({required ExpenseModel expenseObj}) async {
    final db = await DatabaseModel.instance.getDatabase();

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
    final db = await DatabaseModel.instance.getDatabase();
    final dateNow = DateTime.now().millisecondsSinceEpoch;
    var result = await db.query(
      'expenses',
      orderBy: 'id ASC',
      where: 'status = 1 and ((date_start <= ? and date_end >= ?) or date_start is null or date_end is null)',
      whereArgs: [dateNow, dateNow],
    );
    return result.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<double> getTotal() async {
    final db = await DatabaseModel.instance.getDatabase();
    final dateNow = DateTime.now().millisecondsSinceEpoch;
    var result = await db.query(
      'expenses',
      columns: ['sum(value) as total'],
      orderBy: 'id ASC',
      where: 'status = 1 and ((date_start <= ? and date_end >= ?) or date_start is null or date_end is null)',
      whereArgs: [dateNow, dateNow],
    );
    return result[0]['total'] == null ? 0.0 : double.parse(result[0]['total'].toString());
  }

  Future<bool> deleteExpense(int id) async {
    final db = await DatabaseModel.instance.getDatabase();
    var result = await db.update(
      'expenses',
      {'status': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    print(result);
    if (result != 0){
      return true;
    } else {
      return false;
    }

  }
}
