import 'dart:developer';
// import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

abstract class LocalDataSource {
  //Create Data
  Future<int> createItem(Map<String, dynamic> data);
  //Get All Data
  Future<List<Map<String, dynamic>>> getItems();
  //Update Data
  Future<int> updateItem(int id, Map<String, dynamic> data);
  //Delete Data
  Future<void> deleteItem(int id);
}

class LocalDataSourceImpl implements LocalDataSource {
  //Create Table
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
     CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      count INTEGER DEFAULT 0
  );
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("devaxis.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    },
    onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // count ustunini jadvalga qo'shish
          await db.execute("""
            ALTER TABLE items ADD COLUMN count INTEGER DEFAULT 0;
          """);
        }
      },
    
    );
  }

  Future<int> createItem(Map<String, dynamic> data) async {
    final db = await LocalDataSourceImpl.db();

    final id = await db.insert("items", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await LocalDataSourceImpl.db();

    return db.query("items", orderBy: "id");
  }

  Future<int> updateItem(int id, Map<String, dynamic> data) async {
    final db = await LocalDataSourceImpl.db();
    final result =
        await db.update("items", data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<void> deleteItem(int id) async {
    final db = await LocalDataSourceImpl.db();
    try {
      log("Deleteed");
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (error) {
      log("Something went to wrong when deketing an item: $error");
    }
    return;
  }
}
