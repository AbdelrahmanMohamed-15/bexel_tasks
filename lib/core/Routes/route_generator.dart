import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../Feature/NavBar/Presentation/Views/navbar_screen.dart';
import '../../feature/authentication/presentation/views/login_screen.dart';
import '../../feature/authentication/presentation/views/splach_screen.dart';
import '../../feature/authentication/presentation/cubit/auth_cubit.dart';
import '../../feature/navbar/presentation/cubit/navbar_cubit.dart';
import '../../feature/home/presentation/views/task_details_screen.dart';
import '../../feature/home/presentation/views/add_task_screen.dart';
import '../../feature/home/presentation/cubit/home_cubit.dart';
import '../../Core/Data/app_database.dart';
import '../Constant/base_constant.dart';
import 'app_navigation.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // var args = settings.arguments;

    //paymentMethod

    switch (settings.name) {
      case AppRoutes.splash:
        return _screenRoute(screen: SplachScreen(), settings: settings);
      case AppRoutes.login:
        return _screenRoute(
          screen: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
            child: LoginScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.bottomBar:
        return _screenRoute(
          screen: BlocProvider<NavbarCubit>(
            create: (context) => NavbarCubit(),
            child: const NavbarScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.taskDetails:
        final task = settings.arguments;
        if (task == null) {
          return _errorRoute();
        }
        return MaterialPageRoute(
          builder: (context) {
            // Try to get HomeCubit from context, if not available create new one
            HomeCubit? homeCubit;
            try {
              homeCubit = BlocProvider.of<HomeCubit>(context);
            } catch (e) {
              homeCubit = HomeCubit();
            }
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: TaskDetailsScreen(task: task as Task),
            );
          },
          settings: settings,
        );
      case AppRoutes.addTask:
        return MaterialPageRoute(
          builder: (context) {
            // Try to get HomeCubit from context, if not available create new one
            HomeCubit? homeCubit;
            try {
              homeCubit = BlocProvider.of<HomeCubit>(context);
            } catch (e) {
              homeCubit = HomeCubit();
            }
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: const AddTaskScreen(),
            );
          },
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _screenRoute({
    Widget? screen,
    RouteSettings? settings,
  }) {
    return MaterialPageRoute(builder: (context) => screen!, settings: settings);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(elevation: 0, title: const Text(BaseConstant.appName)),
          body: Center(
            child: InkWell(
              onTap: () {
                Phoenix.rebirth(AppNavigation.currentContext);
              },
              child: const Text('Try again.'),
            ),
          ),
        );
      },
    );
  }
}
