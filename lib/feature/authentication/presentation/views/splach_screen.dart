import 'package:bexel/Core/Constant/assets_strings.dart';
import 'package:bexel/Core/Data/app_database.dart';
import 'package:bexel/Core/Helper/dependency_injection_helper.dart';
import 'package:bexel/Core/Routes/app_navigation.dart';
import 'package:bexel/Core/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  final _di = DependencyInjectionHelper();

  @override
  void initState() {
    checkUser();
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      AppNavigation.pushReplacementNamed(AppRoutes.login);
    });
  }

  insertNewUser() async {
    final user = UserCompanion(
      name: drift.Value('Bexel Support'),
      email: drift.Value('support@bexel.io'),
      password: drift.Value('123456'),
      phone: drift.Value('+202 2414 3918'),
    );

    await _di.sl<AppDatabase>().insertUser(user);
  }

  checkUser() async {
    List<UserData> users = await _di.sl<AppDatabase>().getAllUsers();
    if (users.isEmpty) {
      insertNewUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(AssetsStrings.appLogo, width: size.width * 0.5),
        ),
      ),
    );
  }
}
