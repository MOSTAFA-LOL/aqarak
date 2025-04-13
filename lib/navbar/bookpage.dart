import 'package:aqarak/screans/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aqarak/provider/book_provider.dart';

class Bookpage extends StatelessWidget {
  const Bookpage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('حجوزاتي ')),
      body: ListView.builder(
        itemCount: bookProvider.bookedHouses.length,
        itemBuilder: (context, index) {
          final property = bookProvider.bookedHouses[index];
          return Column(
            children: [
              
              ListTile(
                title: Text(property.propertyTitle,
                style: Theme.of(context).textTheme.titleMedium,),
                subtitle: Text(property.price,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),),
                trailing: IconButton(
                  icon: Icon(Icons.cancel,
                  color: Colors.redAccent,
                  ),
                  onPressed: () => bookProvider.cancelBooking(property),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}