import 'package:flutterquotes/model/quotes_data.dart';

import 'DatabaseCreator.dart';

class FavouriteRepository {
  static Future<List<Quote>> getAllFavouriteQuotes() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.quotesTable}''';
    final data = await db.rawQuery(sql);
    var list = <Quote>[];
    list.addAll(data.map((c) => Quote.fromJsonDatabase(c)).toList());
    return list;
  }

  static Future<bool> isFavourite(String id) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.quotesTable} WHERE ${DatabaseCreator.id} = $id''';
    final data = await db.rawQuery(sql);
    if (data.isNotEmpty) {
      return true;
    }
    return false;
  }

  static Future<Quote> getQuotes(String id) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.quotesTable} WHERE ${DatabaseCreator.id} = $id''';
    final data = await db.rawQuery(sql);
    if (data.isNotEmpty) {
      return Quote.fromJsonDatabase(data[0]);
    }
    return null;
  }

  static Future<bool> addFavourite(
      String id, String author, String tags, String body) async {
    try {
      final sql = '''INSERT INTO ${DatabaseCreator.quotesTable}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.author},
      ${DatabaseCreator.tags},
      ${DatabaseCreator.body}
    )
    VALUES (?,?,?,?)''';
      List<dynamic> params = [id ?? "", author ?? "", tags ?? "", body ?? ""];
      final result = await db.rawInsert(sql, params);
      DatabaseCreator.databaseLog('Add favourite', sql, null, result, params);
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> removeFavourite(String id) async {
    final sql = '''DELETE FROM ${DatabaseCreator.quotesTable}
    WHERE ${DatabaseCreator.id} == ${id}''';
    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog("Remove from favourite", sql, null, result);
    return true;
  }
}
