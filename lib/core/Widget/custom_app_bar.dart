// import 'package:flutter/material.dart';
// import '../Helper/dependency_injection_helper.dart';
// import '../Themes/app_colors.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback? onBackTap;
//   final VoidCallback? onShareTap;
//   final VoidCallback? callTap;
//   final double height;

//   const CustomAppBar({
//     super.key,
//     this.title = 'الملف الشخصي',
//     this.onBackTap,
//     this.onShareTap,
//     this.callTap,
//     this.height = 80,
//   });

//   @override
//   Widget build(BuildContext context) {
//     UserData? userData = DependencyInjectionHelper()
//         .sl<AuthHandlerInterface>()
//         .getUserData();
//     return SafeArea(
//       child: Container(
//         height: height,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: const BoxDecoration(color: AppColors.primary300),
//         child: Row(
//           children: [
//             // Back button
//             GestureDetector(
//               onTap: onBackTap ?? () => Navigator.of(context).pop(),
//               child: const Icon(
//                 Icons.arrow_back_ios,
//                 color: AppColors.black700,
//               ),
//             ),

//             // Title
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ).setCenter(),
//             ),
//             if (userData?.role?.toLowerCase() != 'client')
//               // Setting icon
//               GestureDetector(
//                 onTap: () {
//                   AppNavigation.pushReplacementNamed(
//                     AppRoutes.editProviderProfile,
//                     arguments: {'isEdit': true},
//                   );
//                 },
//                 child: const Icon(Icons.settings, color: AppColors.black700),
//               ),
//             if (userData?.role?.toLowerCase() == 'client')
//               // Call icon
//               GestureDetector(
//                 onTap: callTap ?? () {},
//                 child: const Icon(Icons.call, color: AppColors.black700),
//               ),
//             if (userData?.role?.toLowerCase() == 'client')
//               const SizedBox(width: 10),
//             if (userData?.role?.toLowerCase() == 'client')
//               // Share icon
//               GestureDetector(
//                 onTap: onShareTap ?? () {},
//                 child: const Icon(Icons.ios_share, color: AppColors.black700),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(height);
// }
