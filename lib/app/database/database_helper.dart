import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/owner_model.dart';
import '../models/repo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    print("DatabaseHelper.database called");
    if (_database != null) {
      print("DatabaseHelper.database returning existing database");
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print("DatabaseHelper._initDatabase called");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'repos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE repos(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        updatedAt TEXT,
        watchers INTEGER,
        ownerLogin TEXT,
        ownerAvatarUrl TEXT
      )
    ''');
  }

  // Insert or update repositories
  Future<void> insertRepos(List<Repo> repos) async {
    print("DatabaseHelper.insertRepos called");
    final db = await database;
    for (var repo in repos) {
      await db.insert(
        'repos',
        {
          'id': repo.id,
          'name': repo.name,
          'description': repo.description,
          'updatedAt': repo.updatedAt.toIso8601String(),
          'watchers': repo.watchers,
          'ownerLogin': repo.owner.login,
          'ownerAvatarUrl': repo.owner.avatarUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Fetch all repositories from the database
  Future<List<Repo>> getRepos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('repos');
    return List.generate(maps.length, (i) {
      return Repo(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        updatedAt: DateTime.parse(maps[i]['updatedAt']),
        watchers: maps[i]['watchers'],
        owner: Owner(
          login: maps[i]['ownerLogin'],
          avatarUrl: maps[i]['ownerAvatarUrl'],
        ),
      );
    });
  }

  // Fetch a subset of repositories for pagination
  Future<List<Repo>> getPaginatedRepos(int page, int perPage) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'repos',
      limit: perPage,
      offset: (page - 1) * perPage,
    );
    return List.generate(maps.length, (i) {
      return Repo(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        updatedAt: DateTime.parse(maps[i]['updatedAt']),
        watchers: maps[i]['watchers'],
        owner: Owner(
          login: maps[i]['ownerLogin'],
          avatarUrl: maps[i]['ownerAvatarUrl'],
        ),
      );
    });
  }
}
