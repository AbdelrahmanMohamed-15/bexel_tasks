import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:bexel/feature/navbar/presentation/cubit/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        var navbarCubit = NavbarCubit.get(context);
        return PopScope(
          canPop: false,
          child: SafeArea(
            child: Scaffold(
              body: PageView(
                controller: navbarCubit.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: navbarCubit.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navbarCubit.currentIndex,
                backgroundColor: AppColors.primary500,
                selectedItemColor: AppColors.natural100,
                unselectedItemColor: AppColors.natural500,
                onTap: (index) {
                  navbarCubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
