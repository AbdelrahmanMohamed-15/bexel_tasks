import 'package:bexel/Core/Routes/app_navigation.dart';
import 'package:bexel/core/Routes/app_routes.dart';
import 'package:bexel/core/Widget/main_app_button.dart';
import 'package:flutter/material.dart';
import '../../../../core/Constant/assets_strings.dart';
import '../../../../core/Themes/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(2, 2),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(-2, -2),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary500, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      IconStrings.driver,
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bexel Support', style: theme.textTheme.titleMedium),
                      SizedBox(height: 5),
                      Text(
                        'support@bexel.io',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          MainAppButton(
            bgColor: AppColors.darkRed,
            child: Text(
              'Logout',
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            onTap: () {
              AppNavigation.pushNamedAndRemoveUntil(AppRoutes.splash);
            },
          ),
        ],
      ),
    );
  }
}
