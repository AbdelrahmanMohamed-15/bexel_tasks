import 'package:drift/drift.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 3, max: 50)();
  TextColumn get email => text().nullable()();
  TextColumn get password => text()();
  TextColumn get phone => text().nullable()();
}
