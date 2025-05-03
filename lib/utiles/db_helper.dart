import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../presentation/user/model/user_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            first_name TEXT,
            last_name TEXT,
            email TEXT,
            avatar_url TEXT,
            local_image_path TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertUser(UserModel user) async {
    final db = await DBHelper.db;
    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<UserModel>> getUsers() async {
    final db = await DBHelper.db;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => UserModel.fromMap(maps[i]));
  }

  static Future<void> updateUserImage(int id, String imagePath) async {
    final db = await DBHelper.db;
    await db.update(
      'users',
      {'local_image_path': imagePath},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
