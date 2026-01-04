import 'dart:io';
import 'package:bexel/feature/authentication/domain/Entities/user.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'tasks_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [User])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Function for get all Users
  Future<List<UserData>> getAllUsers() => select(user).get();

  // Function for Authentication User
  Future<UserData> getUserByEmailandPassword({
    required String email,
    required String password,
  }) async {
    return (select(user)..where(
          (tbl) => tbl.email.equals(email) & tbl.password.equals(password),
        ))
        .getSingle();
  }

  // Function for insert new User
  Future<int> insertUser(UserCompanion users) async {
    return into(user).insert(users);
  }
}
