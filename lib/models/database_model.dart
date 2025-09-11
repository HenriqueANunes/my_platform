import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseModel {
  static Database? _db;

  DatabaseModel._constructor();

  static final DatabaseModel instance = DatabaseModel._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');
    final database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (Database db, int newVersion) async {
        //Start from version 1 to current version and create DB
        for (int version = 0; version < newVersion; version++) {
          await _performDBUpgrade(db, version + 1);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        //Iterate from the current version to the latest version and execute SQL statements
        for (int version = oldVersion; version < newVersion; version++) {
          await _performDBUpgrade(db, version + 1);
        }
      },
    );
    return database;
  }

  static Future<void> _performDBUpgrade(Database db, int upgradeToVersion) async {
    switch (upgradeToVersion) {
      //Upgrade to V1 (initial creation)
      case 1:
        await _updateVersion_1(db);
        break;

      //Upgrades for V2
      case 2:
        await _updateVersion_2(db);
        break;
    }
  }

  static Future<void> _updateVersion_1(Database db) async {
    db.execute("""
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        value REAL,
        date_start INTEGER,
        date_end INTEGER,
        type TEXT,
        is_credit BOOLEAN
      )
    """);
  }

  static Future<void> _updateVersion_2(Database db) async {
    db.execute("""
      CREATE TABLE history_revenue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        yearmonth INTEGER,
        revenue REAL,
        credit REAL,
        other REAL,
        month_expenses REAL,
        liquid_revenue REAL,
        investment_value REAL
      )
    """);
  }

  Future<void> close() async {
    final db = await instance.database;
    return db.close();
  }
}
