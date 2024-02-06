import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _tblBookMark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookMark (
          url TEXT PRIMARY KEY.
          author TEXT,
          title TEXT,
          description TEXT,
          urlToImage TEXT,
          publishedAt TEXT,
          content TEXT
          )
          ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertBookmark(Articlism artilsm) async {
    final db = await database;
    await db!.insert(_tblBookMark, artilsm.toJson());
  }

  Future<List<Articlism>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblBookMark);
    return results.map((res) => Articlism.fromJson(res)).toList();
  }

  Future<Map> getBookmarkByUrl(String url) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblBookMark,
      where: 'url = ?',
      whereArgs: [url],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String url) async {
    final db = await database;
    await db!.delete(
      _tblBookMark,
      where: 'url = ?',
      whereArgs: [url],
    );
  }
}
