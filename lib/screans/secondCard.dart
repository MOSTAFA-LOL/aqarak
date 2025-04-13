
// import 'package:aqarak/screans/housedetalesscrean.dart';

// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class Secondcard extends StatelessWidget {
//     Secondcard({super.key,});

// List<dynamic> users = [];

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         mainAxisExtent: 355,
//       ),
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users[index];
//         final name = user['propertyTitle'];
//         final status = user['status'];
//         final price = user['price'];
//         final propertyType = user['propertyType'];

//         return GestureDetector(
//           // Inside the GridView.builder's GestureDetector onTap:
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => HouseDetalesScrean()),
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             width: 160,
//             // padding: EdgeInsets.all(1),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 6,
//                   // offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Stack(
//                 children: [
//                   // الصورة
//                   Image.asset(
//                     'assets/images/japan.png',
//                     // fit: BoxFit.fill,
//                   ),
//                   // التدرج اللوني
//                   Positioned.fill(
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Colors.transparent,
//                             const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
//                           ],
//                           stops: const [0, 1],
//                         ),
//                       ),
//                     ),
//                   ),
//                   // شارة الحالة
//                   Positioned(
//                     top: 16,
//                     right: 16,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         status == 'For Rent' ? 'للإيجار' : 'للبيع',
//                         style: const TextStyle(
//                           color: Color.fromARGB(157, 18, 126, 4),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // معلومات العقار
//                   Positioned(
//                     left: 16,
//                     right: 16,
//                     bottom: 16,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: Theme.of(
//                             context,
//                           ).textTheme.titleSmall?.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           strutStyle: StrutStyle(),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           propertyType,
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(color: Colors.white.withOpacity(0.9)),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           '\$$price',
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(color: Colors.white.withOpacity(0.9)),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
