import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

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
      onCreate: _createDb,
    );
    return database;
  }

  Future<void> _createDb(Database db, int version) async {
    // this method runs only once. when the database is being created

    db.execute("""
      CREATE TABLE financas (
        id INTEGER PRIMAY KEY,
        name TEXT,
        value REAL,
        date_start INTEGER,
        date_end INTEGER,
        tipo TEXT
      )
    """);
  }
}
