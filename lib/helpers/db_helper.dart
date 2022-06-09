import 'dart:developer';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/utils/utils.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'users.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE users_data(user_id INT PRIMARY KEY,first_name TEXT,last_name TEXT,full_name TEXT,age INT,gender TEXT)');
      },
      version: 1,
    );
  }

  static Future<int?> getDataCount(String table) async {
    final db = await DBHelper.database();
    final count = firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    print('users count $count');
    return count;
  }
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    final count = firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    final _dbData=await db.query(table);
    log('our data from dataBase ${_dbData.toString()}');
    return _dbData;
  }

  static Future<void> insert({required String table, required Map<String, dynamic> data}) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

 static Future<List<Map<String, dynamic>>> getSearchData(
      String table, String query,List<dynamic> args) async {
    final db = await DBHelper.database();
    final dbData=await db.rawQuery(query,args);
    log('our search Data ${dbData.length}');
    log('our search Data ${dbData.toString()}');
    return dbData;
  }
}
