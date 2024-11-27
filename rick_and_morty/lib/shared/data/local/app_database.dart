import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'rickandmorry.db';
  final String tableName = 'characters';

  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        String query =
            'create table $tableName (id integer primary key, name text, status text, species text, image text)';
        db.execute(query);
      },
    );
    return db as Database;
  }
}
