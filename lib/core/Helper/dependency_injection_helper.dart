import 'package:bexel/Core/Data/app_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../../feature/authentication/presentation/cubit/auth_cubit.dart';
import '../../feature/home/presentation/cubit/home_cubit.dart';
import '../../feature/navbar/presentation/cubit/navbar_cubit.dart';

class DependencyInjectionHelper {
  final sl = GetIt.instance; // sl = service locator
  // final NotificationService _notificationService = NotificationService();

  /// Registering all components to be able to use them later in the app
  /// Note: don't forget to call this in main.dart
  Future<void> init() async {
    await _registerCoreDependencies();
    await _registerDataSources();
    await _registerRepositories();
    await _registerUseCases();
    await _registerBloc();
    // await _initFirebase();
  }

  /// Registers all core components like services
  Future<void> _registerCoreDependencies() async {
    final AppDatabase appDatabase = AppDatabase();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    sl.registerFactory(() => appDatabase);
    sl.registerLazySingleton(() => flutterSecureStorage);
  }

  /// Registers any [DATA SOURCE]
  Future<void> _registerDataSources() async {}

  /// Registers any [REPOSITORY]
  Future<void> _registerRepositories() async {}

  /// Registers any [USE CASE]
  Future<void> _registerUseCases() async {}

  /// Registers any [Bloc]
  Future<void> _registerBloc() async {
    // Auth Cubit
    sl.registerFactory(() => AuthCubit());
    // navbar Cubit
    sl.registerFactory(() => NavbarCubit());
    // home Cubit
    sl.registerFactory(() => HomeCubit());
  }
}
