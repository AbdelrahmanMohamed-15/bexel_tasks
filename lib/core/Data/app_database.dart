import 'dart:io';
import 'package:bexel/feature/authentication/domain/Entities/user.dart';
import 'package:bexel/feature/home/domain/tasks.dart';
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

@DriftDatabase(tables: [User, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Add tasks table for version 2
        await m.createTable(tasks);
      }
    },
  );

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

  // Function for get all Tasks
  Future<List<Task>> getAllTasks() => select(tasks).get();

  // Function for get all Tasks as Stream
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  // Function for insert new Task
  Future<int> insertTask(TasksCompanion newtask) async {
    return into(tasks).insert(newtask);
  }

  // Function for update Task
  Future<bool> updateTask(Task task) async {
    return update(tasks).replace(task);
  }

  // Function for delete Task
  Future<int> deleteTask(Task task) async {
    return delete(tasks).delete(task);
  }

  // Function for get Task by ID
  Future<Task?> getTaskById(int id) async {
    return (select(tasks)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
