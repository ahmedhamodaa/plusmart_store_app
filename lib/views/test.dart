// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   const Test({super.key});

//   @override
//   Widget build(BuildContext context) {
      
//     // super.build(context);
//     return CustomScrollView(
//       slivers: <Widget>[
//         SliverAppBar(
//           toolbarHeight: 120,
//           title: Padding(
//             padding: const EdgeInsets.only(top: 8, right: 8),
//             child: Column(
//               spacing: 6,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.shopping_cart_rounded,
//                         color: Color(0xff4A4B4D),
//                         size: 24,
//                       ),
//                     ),
//                     Text("مساء الخير ... أحمد", style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//                 Text(
//                   'التوصيل الي',
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: SizedBox(
//                         width: 98,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SvgPicture.asset('assets/icons/down_arrow.svg'),
//                             Text(
//                               'الموقع الحالي',
//                               style: TextStyle(fontSize: 15),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           automaticallyImplyLeading: false,
//           floating: true,
//           pinned: true,
//           snap: true,
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(88.0),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: SearchBar(
//                 hintText: "البحث عن طعام",
//                 onChanged: (value) {
//                   print('Search value: $value');
//                 },
//                 padding: MaterialStateProperty.all(
//                   EdgeInsets.symmetric(horizontal: 16.0),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Main content wrapped in SliverList instead of SliverFillRemaining
//         SliverList(
//           delegate: SliverChildListDelegate([]))]);
//   }
// }