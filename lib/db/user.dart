import 'package:sqflite/sqflite.dart';

final String tableUser = 'user';
final String columnId = '_id';
final String columnFirstname = 'firstname';
final String columnLastname = 'lastname';

class User {
  int id;
  String firstname;
  bool lastname;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnFirstname: firstname,
      columnLastname: lastname
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  User();

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    firstname = map[columnFirstname];
    lastname = map[columnLastname];
  }
}

class UserProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableUser ( 
          $columnId integer primary key autoincrement, 
          $columnFirstname text not null,
          $columnLastname text not null)
        ''');
    });
  }

  Future<User> insert(User user) async {
    user.id = await db.insert(tableUser, user.toMap());
    return user;
  }

  Future<User> getUser(int id) async {
    List<Map> maps = await db.query(tableUser,
        columns: [columnId, columnLastname, columnFirstname],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    return await db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async => db.close();
}