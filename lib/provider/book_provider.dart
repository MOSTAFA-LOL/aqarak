
import 'package:aqarak/data/property.dart';
import 'package:flutter/material.dart';


// import 'package:provider/provider.dart';


class BookProvider extends ChangeNotifier {
  final List<Property> _bookedHouses = [];

  List<Property> get bookedHouses => _bookedHouses;

  void bookHouse(Property property) {
    _bookedHouses.add(property);
    notifyListeners();
  }

  void cancelBooking(Property property) {
    _bookedHouses.remove(property);
    notifyListeners();
  }

  static of(BuildContext context) {}
}