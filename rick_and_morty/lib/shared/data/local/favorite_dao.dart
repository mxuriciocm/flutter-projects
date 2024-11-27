import 'package:rick_and_morty/shared/data/local/app_database.dart';
import 'package:rick_and_morty/shared/data/local/favorite_model.dart';

class FavoriteDao {
  Future<List<FavoriteModel>> getAllFavorites() async {
    final db = await AppDatabase().openDb();
    final List maps = await db.query(AppDatabase().tableName);
    return maps.map((map) => FavoriteModel.fromMap(map)).toList();
  }

  Future<void> insertFavorite(FavoriteModel character) async {
    final db = await AppDatabase().openDb();
    await db.insert(
      AppDatabase().tableName,
      character.toMap(),
    );
  }

  Future<void> deleteFavorite(int id) async {
    final db = await AppDatabase().openDb();
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(int id) async {
    final db = await AppDatabase().openDb();
    List maps = await db.query(
      AppDatabase().tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
