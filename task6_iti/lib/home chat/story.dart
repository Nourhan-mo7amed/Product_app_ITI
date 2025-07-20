// import 'package:flutter/material.dart';

// class StoryList extends StatelessWidget {
//   const StoryList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.all(8),
//         itemCount: 8,
//         separatorBuilder: (context, index) => const SizedBox(width: 10),
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               Stack(
//                 children: [
//                   const CircleAvatar(
//                     radius: 25,
//                     backgroundImage: AssetImage('Assets/images/image2.png'),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 12,
//                       height: 12,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 5),
//               const Text("nourhan", style: TextStyle(fontSize: 12))
//             ],
//           );
//         },
//       ),
//     );
//   }
// }