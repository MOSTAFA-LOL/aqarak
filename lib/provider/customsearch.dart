// import 'package:aqarak/data/data.dart';

// import 'package:flutter/material.dart';


// class Customsearch extends SearchDelegate {
//   // ignore: non_constant_identifier_names
//   Customsearch({required this.cardView});

//   final List<House> cardView;
//   List<House> localResult = [];

//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//             onPressed: () => query.isEmpty ? close(context, null) : query = '',
//             icon: Icon(Icons.clear))
//       ];

//   @override
//   Widget? buildLeading(BuildContext context){
//     return null;
//   }
//     // => IconButton(
//     //   onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));

//   @override
//   Widget buildResults(BuildContext context) => localResult.isEmpty
//       ? Text('لا توجد نتائج بحث',
//       style: Theme.of(context).textTheme.bodyMedium,

//       )
//       : Secondcard(
        
//         );

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     localResult = cardView.where((House card) {
//       final String title = card.name;
//       final String place = card.place;
//       final String input = query;
//       return title.contains(input) || place.contains(input);
//     }).toList();
//     return localResult.isEmpty
//         ? Center(
//             child: Text('لا توجد نتائج بحث'
//             ,
//             style: Theme.of(context).textTheme.bodyMedium,),
//           )
//         : Secondcard();
//   }
// }
