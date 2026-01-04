// import 'package:flutter/material.dart';

// import '../Themes/app_colors.dart';

// class ProviderCard extends StatelessWidget {
//   final String name;
//   final String image;
//   final String averageRating;
//   final String totalRatings;
//   const ProviderCard({
//     super.key,
//     required this.name,
//     required this.image,
//     required this.averageRating,
//     required this.totalRatings,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       tileColor: AppColors.natural200.withValues(alpha: 0.3),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       leading: CircleAvatar(
//         backgroundColor: AppColors.natural200.withValues(alpha: 0.5),
//         radius: 20,
//         backgroundImage: NetworkImage(provider.image!),
//       ),
//       title: Text(
//         '${provider.firstName} ${provider.lastName}',
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.black700),
//       ),
//       subtitle: RichText(
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         text: TextSpan(
//           children: [
//             WidgetSpan(
//               child: Icon(Icons.star, color: Colors.amberAccent, size: 18),
//             ),
//             TextSpan(text: '  '),
//             TextSpan(
//               text: '${provider.avgRate}',
//               style: theme.textTheme.bodySmall?.copyWith(
//                 color: AppColors.black700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
