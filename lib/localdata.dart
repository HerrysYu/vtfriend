import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class journal {
  String content;
  int day;
  int month;
  int year;
  int id;
  journal(
      {required this.content,
      required this.day,
      required this.month,
      required this.year,
      required this.id});
  Map<String, Object?> toMap() {
    return {
      'content': content,
      'day': day,
      'month': month,
      'year': year,
      'id': id
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'journal{id:$id, day: $day, month: $month, year: $year, content:$content}';
  }
}

class sqlhelper {
  InsertJournal(journal journal) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'journals_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE journals(id INTEGER PRIMARY KEY, day INTEGER, month INTEGER, content TEXT, year INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    db.insert('journals', journal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<journal>> journals() async {
    // Get a reference to the database.
    final db = await openDatabase(
      join(await getDatabasesPath(), 'journals_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE journals(id INTEGER PRIMARY KEY, day INTEGER, month INTEGER, content TEXT, year INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // Query the table for all the dogs.
    final List<Map<String, Object?>> journalsmaps = await db.query('journals');
    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
            'id': id as int,
            'year': year as int,
            'day': day as int,
            'month': month as int,
            'content': content as String
          } in journalsmaps)
        journal(day: day, year: year, id: id, month: month, content: content),
    ];
  }

  Future<void> updatejournals(journal journal) async {
    final db = await openDatabase(
        join(await getDatabasesPath(), 'journals_database.db'),
        version: 1);
    db.update('journals', journal.toMap(),
        where: 'id=?', whereArgs: [journal.id]);
  }

  Future<void> deletejournal(int id) async {
    final db = await openDatabase(
        join(await getDatabasesPath(), 'journals_database.db'),
        version: 1);
    db.delete('journals', where: 'id=?', whereArgs: [id]);
  }

  Future<int> getCount() async {
    //database connection
    final db = await openDatabase(
        join(await getDatabasesPath(), 'journals_database.db'),
        version: 1);
    var x = await db.rawQuery('SELECT COUNT (*) from journals');
    int count = Sqflite.firstIntValue(x)! + 1;
    return count;
  }
}
